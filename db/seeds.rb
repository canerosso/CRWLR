puts "Creating Users"

u1 = User.create(name: "Nick", username: "NickM", password: "123")
u2 = User.create(name: "Ken", username: "KenA", password: "123")

puts "Users created"
puts "Creating loads of restaurants"

file = File.read('db/Yelp_JSON/LV_open_restaurants_processed.json')
data = JSON.parse(file)

# binding.pry

data["restaurants"].each do |place|
  # binding.pry
  if place["attributes"] != nil
    # binding.pry
    Place.find_or_create_by(business_id: place["business_id"], name: place["name"], address: place["address"], city: place["city"], state: place["state"], postal_code: place["postal_code"], latitude: place["latitude"], longitude: place["longitude"], stars: place["stars"], price_range: place["attributes"]["RestaurantsPriceRange2"], categories: place["categories"])
    puts "Loaded #{place["name"]}"
  else
    Place.find_or_create_by(business_id: place["business_id"], name: place["name"], address: place["address"], city: place["city"], state: place["state"], postal_code: place["postal_code"], latitude: place["latitude"], longitude: place["longitude"], stars: place["stars"], price_range: nil, categories: place["categories"])
    puts "Loaded #{place["name"]}"
  end
end

puts "Created restaurants"
puts "Creating loads of bars"

file = File.read('db/Yelp_JSON/LV_open_bars_processed.json')
data = JSON.parse(file)

data["bars"].each do |place|
  # binding.pry
  if !place["attributes"] == nil
    Place.find_or_create_by(business_id: place["business_id"], name: place["name"], address: place["address"], city: place["city"], state: place["state"], postal_code: place["postal_code"], latitude: place["latitude"], longitude: place["longitude"], stars: place["stars"], price_range: place["attributes"]["RestaurantsPriceRange2"], categories: place["categories"])
    puts "Loaded #{place["name"]}"
  else
    Place.find_or_create_by(business_id: place["business_id"], name: place["name"], address: place["address"], city: place["city"], state: place["state"], postal_code: place["postal_code"], latitude: place["latitude"], longitude: place["longitude"], stars: place["stars"], price_range: nil, categories: place["categories"])
    puts "Loaded #{place["name"]}"
  end
end

puts "Created bars"
