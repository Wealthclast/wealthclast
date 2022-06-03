# Rename this to FullAccountSync?, since some actions here will be needed for when:
# - the account has new chars in different leagues
# - the account has new stash tabs
# It has to be idempotent
class SignupStarter
  def initialize(access_token:)
    @apli_client = PathOfExile::API.new(access_token: access_token)
  end

  def call(account)
    create_characters(account)
    create_private_leagues(account) if account.any_private_league_not_saved?
    create_league_accounts(account)
    # Snapshot only temp leagues at Signup
    account.league_accounts.temporary.each do |league_account|
      create_stash_tabs(league_account)
      snapshot_league(league_account)
    end
  end

  def create_characters(account)
    @apli_client.account_characters["characters"].each do |char|
      Character.find_or_create_by(_id: char["id"]) do |c|
        c.account = account
        c.league = char["league"]
      end
    end
  end

  def create_private_leagues(account)
    account.private_leagues_not_saved.each do |league_name|
      league = @apli_client.league(name: league_name)["league"]

      # find just in case there is a race condition and another account already
      # created this league
      League.find_or_create_by(name: league_name) do |l|
        l.private = true
        l.realm = league["realm"]
        l.starts_at = league["startAt"]
        l.ends_at = league["endAt"]
        l.description = league["description"]
        l.icon = "private_league_icon.png"
        l.cover = "private_league_cover.png"
        l.slug = league_name.parameterize
      end
    end
  end

  def create_league_accounts(account)
    account.leagues_playing_from_chars.each do |league_name|
      league = League.find_by(name: league_name)

      LeagueAccount.find_or_create_by(
        account: account,
        league: league
      )
    end
  end

  def create_stash_tabs(league_account)
    @apli_client.stashes(league_name: league_account.league.name)["stashes"].each do |stash_tab|
      next unless StashTab::VALID_TYPES.include?(stash_tab["type"])

      if stash_tab["type"] == "Folder"
        stash_tab["children"].each do |substash|
          next unless StashTab::VALID_TYPES.include?(substash["type"])

          create_stash_tab(substash, league_account)
        end
      else
        next unless StashTab::VALID_TYPES.include?(stash_tab["type"])

        create_stash_tab(stash_tab, league_account)
      end
    end
  end

  def create_stash_tab(stash_tab, league_account)
    StashTab.find_or_create_by(_id: stash_tab["id"]) do |s|
      s.name = stash_tab["name"]
      s.type = stash_tab["type"]
      s.league_account = league_account
    end
  end

  def snapshot_league(league_account)
    # CreateSnapshot.new(access_token: access_token).call(league_account: league_account)
    snapshot = Snapshot.create(league_account: league_account)
    league_account.stash_tabs.each do |stash_tab|
      response = @apli_client.stash(league_name: league_account.league.name, stash_id: stash_tab._id)
      create_snapshot(response, league_account, snapshot)
    end
  end

  def create_snapshot(response, league_account, snapshot)
    return unless response["stash"]

    items = response["stash"]["items"]
    return if items.blank?

    items.each do |item|
      next if Item::CURRENCY_FRAME_TYPE != item["frameType"]
      next if Item::IGNORED_ITEMS.include? item["baseType"]

      ItemSnapshot.create(
        snapshot: snapshot,
        item_name: item["baseType"],
        league_account: league_account,
        stack_size: item["stackSize"]
      )
    end
  end
end
