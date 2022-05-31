namespace :league do
  desc "Fetch the current leagues and create the missing ones"
  task update_default_leagues: :environment do
    PathOfExile::API.new.leagues["leagues"].each do |league|
      puts "League '#{league["id"]}' is being created"
      League.find_or_create_by(name: league["id"]) do |l|
        l.realm = league["realm"]
        l.starts_at = league["startAt"]
        l.ends_at = league["endAt"]
        l.description = league["description"]
        l.slug = league["id"].parameterize
      end
    end
  end
end
