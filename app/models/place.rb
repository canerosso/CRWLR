class Place < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_many :crawl_places
  has_many :crawls, through: :crawl_places

  validates :address, uniqueness: :true

  RESTAURANT_CATEGORIES = ["Mexican",
  "Chinese",
  "French",
  "Creperies",
  "American (Traditional)",
  "Delis",
  "Desserts",
  "Bakeries",
  "Pizza",
  "Salad",
  "Italian",
  "Bagels",
  "Sandwiches",
  "Breakfast & Brunch",
  "American (New)",
  "Burgers",
  "Fast Food",
  "Seafood",
  "Gelato",
  "Ice Cream & Frozen Yogurt",
  "Ramen",
  "Japanese",
  "Tapas/Small Plates",
  "Vietnamese",
  "Noodles",
  "Barbeque",
  "Tex-Mex",
  "Asian Fusion",
  "Dim Sum",
  "Cafes",
  "Tea Rooms",
  "Mediterranean",
  "Steakhouses",
  "Chicken Wings",
  "Hot Dogs",
  "Food Trucks",
  "Food Stands",
  "Caribbean",
  "Korean",
  "Izakaya",
  "Gluten-Free",
  "Macarons",
  "Vegetarian",
  "Diners",
  "Tapas Bars",
  "Waffles",
  "Comfort Food",
  "Latin American",
  "Salvadoran",
  "Tacos",
  "Sushi Bars",
  "Thai",
  "Argentine",
  "Brazilian",
  "Gastropubs",
  "Poke",
  "Middle Eastern",
  "Indian",
  "Acai Bowls",
  "Hawaiian",
  "Chicken Shop",
  "Southern",
  "Buffets",
  "Vegan",
  "Soul Food",
  "Greek",
  "Halal",
  "Cheesesteaks",
  "Filipino",
  "Soup",
  "Mongolian",
  "Bistros",
  "Tuscan",
  "Arabian",
  "Pakistani",
  "Donuts",
  "African",
  "Laotian",
  "Cantonese",
  "Colombian",
  "Bubble Tea",
  "Pretzels",
  "Empanadas",
  "Wraps",
  "Peruvian",
  "Egyptian",
  "Delicatessen",
  "Smokehouse",
  "Cajun/Creole",
  "Pan Asian",
  "Honduran",
  "Fish & Chips",
  "Szechuan",
  "Taiwanese",
  "Japanese Curry",
  "Cuban",
  "Spanish",
  "Kebab",
  "Irish",
  "Venezuelan",
  "Hot Pot",
  "Portuguese",
  "German",
  "Scandinavian",
  "Fondue",
  "Live/Raw Food",
  "Kosher",
  "New Mexican Cuisine",
  "Modern European",
  "British",
  "Seafood Markets",
  "Puerto Rican",
  "Teppanyaki",
  "Austrian",
  "Persian/Iranian",
  "Ethiopian",
  "Conveyor Belt Sushi",
  "Lebanese",
  "Guamanian",
  "Falafel",
  "Singaporean",
  "Malaysian",
  "Soba",
  "Armenian",
  "Poutineries",
  "Ukrainian",
  "Afghan",
  "Turkish",
  "Moroccan"].sort

  BAR_CATEGORIES = ["Oxygen Bars",
  "Comedy Clubs",
  "Speakeasies",
  "Champagne Bars",
  "Cigar Bars",
  "Brewpubs",
  "Whiskey Bars",
  "Pool Halls",
  "Tiki Bars",
  "Country Dance Halls",
  "Beer Garden",
  "Beer Gardens",
  "Irish Pub",
  "Piano Bars",
  "Gay Bars",
  "Karaoke",
  "Wineries",
  "Breweries",
  "Wine Bars",
  "Beer Bar",
  "Beach Bars",
  "Lounges",
  "Cocktail Bars",
  "Dance Clubs",
  "Hookah Bars",
  "Dive Bars",
  "Pubs",
  "Sports Bars",
  "Nightlife",
  "Cabaret"].sort

  def self.categories
    all_places = Place.all
    cats = all_places.map do |place|
      place.categories
    end
    # byebug
    cats = cats.map do |cat|
      cat.split(", ")
    end
    cats.flatten!.uniq!
  end

  def self.bar_categories
    BAR_CATEGORIES
  end

  def self.restaurant_categories
    RESTAURANT_CATEGORIES
  end

  def self.search(categories)
    # returns a list of 10 places closest with matching categories to the last place
    results = categories.map do |cat|
      Place.where("Categories LIKE ?", "%#{cat}%")
    end
    results.flatten!
  end

  def self.sort_by_distance(places, last_place)
    sorted = places.sort_by do |place|
      Geocoder::Calculations.distance_between(place, last_place)
    end
    first_ten = sorted[0..9]
  end

end
