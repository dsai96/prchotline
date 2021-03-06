require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#county_list = ["Adams", "Allegheny", "Armstrong", "Beaver", "Bedford", "Berks", "Blair", "Bradford", "Bucks", "Butler", "Cambria", "Cameron", "Carbon", "Centre", "Chester", "Clarion", "Clearfield", "Clinton", "Columbia", "Crawford", "Cumberland", "Dauphin", "Delaware", "Elk", "Erie", "Fayette", "Forest", "Franklin", "Fulton", "Greene", "Huntingdon", "Indiana", "Jefferson", "Juniata", "Lackawanna", "Lancaster", "Lawrence", "Lebanon", "Lehigh", "Luzerne", "Lycoming", "Mckean", "Mercer", "Mifflin", "Monroe", "Montgomery", "Montour", "Northampton", "Northumberland", "Perry", "Philadelphia", "Pike", "Potter", "Schuylkill", "Snyder", "Somerset", "Sullivan", "Susquehanna", "Tioga", "Union", "Venango", "Warren", "Washington", "Wayne", "Westmoreland", "Wyoming", "York"]

# county_list.each do |name|
#   County.create( name: name)
# end

csv_text = File.read('countyCoordinators.csv')
csv = CSV.parse(csv_text, :headers => true)
countyZip = {}
csv.each do |row|
  countyName = row["County"]
  countyCoord = row["Coordinator "]
  countyPhone = row["Phone #"]
  countyWebsite = row["Website"]
  if countyCoord == 'N/A'
    countyCoord = nil
  end
  if countyPhone == 'N/A'
    countyPhone = nil
  end
  if countyWebsite == 'N/A'
    countyWebsite = nil
  end
  County.create( name: countyName, coordinator: countyCoord, phone: countyPhone, website: countyWebsite)
end

item_list = ["Paper", "Television"]

item_list = ["Air Conditioners", "Aluminum", "Ammunition", "Antifreeze", "Appliances (with Freon)", "Appliances (No Freon)", "Art & Education Materials", "Asbestos", "Aseptic Packaging (Drink Boxes/Milk Cartons)", "Asphalt, Brick, Concrete, Gravel, & Porcelain", "Audio/Videotapes, CDs, DVDs, & Records", "Automotive Parts & Liquids",
"Ballast", "Batteries (Alkaline/Zinc Carbon)", "Batteries (Button Cell)", "Batteries (Lead Acid)", "Batteries (Rechargable)", "Biohazardous Waste", "Books","Bricks","Building Materials","Light Bulbs",
"Car/Vehicle Donations", "Car Seats", "Cardboard","Carpet","Cartons","Cell Phones","Christmas Lights","Christmas Trees","Clothing/Textiles","CFL Bulbs","Compost","Computers","Concrete","Construction/Demolition Materials","Cooking Oil",
"Cork",
"Couches",
"Cylinders",
"Data Destruction",
"Dehumidifier",
"Donations",
"Drugs",
"Driveway Sealer",
"Drywall",
"Electronic Equiptment",
"Eyeglasses",
"Filters",
"Fire Extinguishers",
"Fishing Lines",
"Flares",
"Fluorescent Lights",
"Foam",
"Food",
"Freon",
"Fuels/Solvents",
"Furniture",
"Glass",
"Grease",
"Greeting Cards",
"Grocery Bags",
"Hangers",
"Hazardous Waste",
"Helium Tanks",
"Humidifier",
"Ink Cartridges",
"Junk Removal",
"Junk Mail",
"Kerosene",
"Medicine",
"Mercury",
"Microwaves",
"Milk Cartons & Drink Boxes",
"Mobile Phones",
"Monofilament (Fishing Line)",
"Motor Oil",
"Needles",
"Oil",
"Oil Heaters",
"Packaging Peanuts",
"Paint (Oil/Solvent Base)",
"Paper",
"Paper Shredding",
"Pesticides",
"Pet Supplies",
"Phone Books",
"Phones",
"Plastic",
"Plastic Bottle Caps",
"Polystyrene",
"Pool Chemicals",
"Prom Dresses",
"Propane Tanks",
"Railroad Ties",
"Rain Barrels",
"Refrigerators",
"Scrap & Metal",
"Sharps/Syringes",
"Shoes",
"Smoke Detectors",
"Solvents",
"Sporting Goods",
"Styrofoam/Expanded Polystyrene",
"Syringes",
"Tanks",
"Telephone Books",
"Televisions",
"Thermostats",
"Tires",
"Toner/Laser Cartridges",
"Wood",
"X-Ray & MRI Film",
"Yard Waste"]
item_list.each do |name|
  index = name
  if name.split(" ").count == 1
    index = name.singularize
  end
  @item = Item.create( name: index.downcase, description: "Nothing just yet", active: true)

  # @item.aliases.create(name: name.downcase, active: true)
  if name == "Mobile Phones"
    @item.aliases.create(name: "Cellphone".downcase, active: true)
  elsif name == "Televisions"
    @item.aliases.create(name: "TV".downcase, active: true)
  elsif name == "Light Bulbs"
    @item.aliases.create(name: "Bulb".downcase, active: true)
  end
  Rails.logger.info(@item.errors.inspect)
end
# Item.create(name: 'Paint', description: 'Paint needs to be disposed of properly to protect the environment.', active: true)
# Item.create(name: 'Television', description: 'Nothing right now', active: true)
# Item.create(name: 'Shredded Paper', description: 'Nothing right now', active: false)

# Location.create(name: 'Best Buy', address: '123 Main Street', city: 'Lancaster', phone: '4123211234', website: 'bestbuy.com', zipcode: '15123', state: 'PA')
# Location.create(name: 'Giant Eagle', address: '321 Hello Street', city: 'Pittsburgh', phone: '4123214567', website: 'gianteagle.com', zipcode: '15289', state: 'PA')

# i = 0
# County.all.each do |county|
#   i += 1
  # address =
#   Location.create(name: (county.name+'Recycling Facility'+i), address: '')
#
# end

csv_text = File.read('zipcodes.csv')
csv = CSV.parse(csv_text, :headers => true)
countyZip = {}
csv.each do |row|

  if row['county']
    county = row['county'].split(' ')[0]
    if countyZip.key?(county)
      countyZip[county].push([row['zip'],row['primary_city'], row['latitude'], row['longitude']])
    else
      countyZip[county] = [[row['zip'],row['primary_city'], row['latitude'], row['longitude']]]
    end
  end

end
# Faker::Config.locale = 'en-US'
# counter = 0
# County.all.each do |c|
#   county = c.name
#   zipcodes = countyZip[county]
#   if countyZip.key?(county)
#     count = 1
#     zipcodes.each do |zipCity|
#       rand(3).times do |tmp|
#
#         address = "#{Faker::Address.street_address} Ave."
#         phone = (Faker::PhoneNumber.phone_number).split('x')[0]
#         # c.locations.create(name: "#{county} Recycling Facility ##{count} in #{zipCity[1]}", address: address, city: zipCity[1], phone: phone, website: 'www.example.com', zipcode: zipCity[0], state: 'PA', counties_id: c.id, active: true)
#         @loc1 = Location.new(name: "#{county} Recycling Facility ##{count} in #{zipCity[1]}", phone: phone, website: 'www.example.com', active: true)
#
#         @loc1.addresses.build(address: address, city: zipCity[1], zipcode: zipCity[0], state: 'PA', county_id: c.id,location_id: @loc1.id, latitude: zipCity[2], longitude: zipCity[3], active: true)
#         @loc1.save
#         # @loc1 = Location.create(name: "#{county} Recycling Facility ##{count} in #{zipCity[1]}", phone: phone, website: 'www.example.com', active: true)
#
#         # @addr1 = Address.create(address: address, city: zipCity[1], zipcode: zipCity[0], state: 'PA', county_id: c.id,location_id: @loc1.id, latitude: zipCity[2], longitude: zipCity[3], active: true)
#         Rails.logger.info(@loc1.errors.inspect)
#         # Rails.logger.info(@addr1.errors.inspect)
#
#         count += 1
#       end
#     end
#   end
# end
# fileNames = ['BucksCountyData.csv', 'Alle3.csv', 'Philadelphia.csv','Montgomery.csv','Lehigh.csv', 'Butler.csv','Beaver.csv', ]
locations = {}
tmpPath = Rails.root.join("county-data")
Dir.foreach(tmpPath) do |fname|
  next if fname == '.' or fname == '..'
  # do work on real items
  path = Rails.root.join("county-data/#{fname}")
  csv_text = File.open(path, "r:ISO-8859-1")
  csv = CSV.parse(csv_text, :headers => true)
  countyZip = []

  csv.each do |row|

    if row['Location Name']
      name = row['Location Name'].strip
      if row["Item"] && row["County"]
        item = row["Item"].downcase.strip
        # puts item
        county = row['County'].strip.split(' ')[0]
        # puts county
        # puts county
        if row["Address"]
          if !locations.key?(name)
            locations[name] = {}




            locations[name]["Addr"] = [[row['City'],row["Address"], row["Location Name"], row['Phone'], row['Website'],row["Details"], county]]
            locations[name][item] = row["Details"]

          else




            locations[name]["Addr"].push([row['City'],row["Address"], row["Location Name"], row['Phone'], row['Website'],row["Details"], county])
            locations[name][item] = row["Details"]

          end
        end



      end
    else
      puts row

    end

  end
end

# fileNames.each do |fname|
#   # csv_text = File.read(fname)
#
#
# end
locations.each do |addr, items|
  row1 = items["Addr"][0]
  @loc1 = Location.new(name: row1[2], phone: row1[3], website: row1[4], active: true)
  items["Addr"].each do |row|
    c = County.for_name(row[6]).first
    flag = false
    @loc1.addresses.each do |addr_rows|
      addr1 = addr_rows.address
      # addr1 = addr_rows[1]
      if row[1].strip == addr1.strip
        flag = true
      end
    end
    if !flag
      city = ""
      address1 = ""
      unless row[0].nil?

        city = row[0].strip
      end
      unless row[1].nil?
        address1 = row[1].strip
      end
      @loc1.addresses.build(address: address1, city: city, zipcode: "", state: 'PA', county_id: c.id, location_id: @loc1.id, active: true)
    end


  end
  items.each do |item, emp|
    if item != "Addr"
      index = item
      if item.split(" ").count == 1
        index = item.singularize
      end
      i = Item.for_name(index.downcase).first
      if i.nil?
        a = Alias.for_name(index.downcase).first
        if a.nil?
          puts "#{item} is nil"
        else
          @loc1.item_locations.build(item_id: a.item.id, location_id: @loc1.id, context: emp ,active: true)
        end

      else
        @loc1.item_locations.build(item_id: i.id, location_id: @loc1.id, context: emp ,active: true)
      end

    end


  end
  @loc1.save



end



# countyZip.each do |county, zipcodes|
#
# end

# items = Item.all
# locs = Location.all
# items.each do |item|
#   if ["paper", "televisions","mobile phones","cardboard"].include?(item.name)
#     locs.each do |loc|
#
#       @asd = ItemLocation.create(item_id: item.id, location_id: loc.id, context: "This is an example context. We don't know much beyond this.",active: true)
#       Rails.logger.info(@asd.errors.inspect)
#     end
#   end
# end
