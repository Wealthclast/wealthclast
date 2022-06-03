# First Signup
# 1. Fetch and save characters
# 2. Create private leagues if any
# 3. Create LeagueAccount records for all playing leagues
# 4. Fetch stashes from temp leagues
#
class SignupStarter
  def initialize(access_token:)
    @apli_client = PathOfExile::API.new(access_token: access_token)
  end

  def call(account)
    @apli_client.account_characters["characters"].each do |char|
      Character.find_or_create_by(_id: char["id"]) do |c|
        c.account = account
        c.league = char["league"]
      end
    end

    account.any_private_league_not_saved?.each do |league_name|
      league = @apli_client.league(name: league_name)["league"]
      League.create(
        name: league_name,
        private: true,
        realm: league["realm"],
        starts_at: league["startAt"],
        ends_at: league["endAt"],
        description: league["description"],
        icon: "private_league_icon.png",
        cover: "private_league_cover.png",
        slug: league_name.parameterize
      )
    end

    account.leagues_playing_from_chars.each do |league_name|
      LeagueAccount.find_or_create_by(account: account, league: League.find_by(name: league_name))
    end

    # stash tabs
    account.league_accounts.temporary.each do |league_account|
      league_name = league_account.league.name
      snapshot = Snapshot.create(league_account: league_account)

      @apli_client.stashes(league_name: league_name)["stashes"].each do |stash|
        next unless StashTab::VALID_TYPES.include?(stash["type"])

        if stash["type"] == "Folder"
          stash["children"].each do |substash|
            next unless StashTab::VALID_TYPES.include?(substash["type"])

            StashTab.find_or_create_by(_id: substash["id"]) do |s|
              s.name = substash["name"]
              s.type = substash["type"]
              s.league_account = league_account
            end

            response = @apli_client.stash(league_name: league_name, stash_id: substash["id"])
            create_snapshot(response, league_account, snapshot)
          end
        else
          next unless StashTab::VALID_TYPES.include?(stash["type"])

          StashTab.find_or_create_by(_id: stash["id"]) do |s|
            s.name = stash["name"]
            s.type = stash["type"]
            s.league_account = league_account
          end

          response = @apli_client.stash(league_name: league_name, stash_id: stash["id"])
          create_snapshot(response, league_account, snapshot)
        end
      end
    end
  end

  def create_snapshot(response, league_account, snapshot)
    return unless response["stash"]
    items = response["stash"]["items"]
    return if items.blank?

    items.each do |item|
      next unless item["frameType"] == Item::CURRENCY_FRAME_TYPE
      next if Item::IGNORED_ITEMS.include?(item["baseType"])
      # TODO:
      # next unless league_account.ignored_items.include? item["baseType"]
      ItemSnapshot.create(
        snapshot: snapshot,
        item_name: item["baseType"],
        league_account: league_account,
        stack_size: item["stackSize"]
      )
    end
  end
end
