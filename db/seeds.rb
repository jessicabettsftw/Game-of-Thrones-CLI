def access_regions
  response = RestClient.get("https://api.got.show/api/regions/")
  JSON.parse(response.body)
  # binding.pry
  # jj["data"]["children"].each_with_index do |post, index|
  # puts "#{index}. " + post["data"]["title"]
end

def seed_regions
  Region.destroy_all
  access_regions.each do |region_hash|
    Region.create(name: region_hash["name"])
  end
end

seed_regions

def access_houses
  response = RestClient.get("https://api.got.show/api/houses/")
  JSON.parse(response.body)
end

def seed_houses
  House.destroy_all
  access_houses.each do |house_hash|
    region_id = Region.find_by(name: house_hash["region"])&.id #in case region doesn't exist
    if region_id && house_hash["coatOfArms"]
      House.create(region_id: region_id,
                  name: house_hash["name"],
                  coat_of_arms: house_hash["coatOfArms"],
                  ancestral_weapon: house_hash["ancestralWeapon"].first)
    end
  end
end

seed_houses

def access_characters
  response = RestClient.get("https://api.got.show/api/characters/")
  JSON.parse(response.body)
end

def seed_characters
  Character.destroy_all
  access_characters.each do |character_hash|
    house_id = House.find_by(name: character_hash["house"])&.id
    if house_id
      Character.create(house_id: house_id,
                        name: character_hash["name"],
                        title: character_hash["titles"].first,
                        culture: character_hash["culture"])
    end
  end
end

seed_characters

def access_events
  response = RestClient.get("https://api.got.show/api/events/")
  JSON.parse(response.body)
end

def seed_events
  Event.destroy_all
  access_events.each do |event_hash|
    if !event_hash["name"].include?("Unnamed") #get's rid of unnamed events from the wonderfully populated API
      Event.create(date: event_hash["date"],
                    name: event_hash["name"])
    end
  end
end

seed_events
