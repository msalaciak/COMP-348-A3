#A3_29644490 Matthew Salaciak
# MAIN FUNCTIONS AND DRIVER CLASS
# I used The Well-Grounded Rubyist TextBook by David A. Black to help with this assignment
# Along with tutorial slides and lecture notes.
# all the main methods required are defined here, both CarMaker class and CarModel subclass are defined in CarMaker.rb
# I include the outputs of the sorted listings, and the new updated listings (one with and without a newly added listing)
# to test this functionality yourself you can uncomment those code at the bottom
# i left some methods uncommented so you can just run and observe, feel free to test as please
# for the searchInventory function, I emailed TA Mary to ask about how to go about inputting a hash as a parameter,
# I currently input a hash but I use different syntax than searchInventory( {“car_maker” => ”Mercedes”})
# I use showroom.searchInventory(car_year: '2017') instead. She said this is fine as long as it does the required output
# Reason for this is the textbook i used explained it this way which I followed to teach myself

require './CarMaker.rb'

class AutoInventoryDriver
  @@inventory = 0
  @@inventoryFilePath = 0


  # this function takes the input file, declares all the regex used to parse it, stores everything thats parsed in its own arrays
  # after that CarMaker object array is created called cars, and then it calls createModel which creates a CarModel object that stores the parameters of each listing
  def convertListings2Catalougue(inventoryFile)
    if not File.exist?(inventoryFile) or File.zero?(inventoryFile)
      abort "Sorry the file you inputted is either missing or empty, please check the file path"
    else
      @@inventoryFilePath = inventoryFile
      @@inventory = File.read(inventoryFile)
      @@inventory = @@inventory.gsub /^@\n/, ''
    end

# all the regex patterns to parse the auto inventory textfile
# features
    @featuresRegex = /\{.*\}/i
#km
    @kmRegex = /(?<=\A|,)\d*km/i
#drive train
    @driveTrainRegex = /\b(?:awd|fwd|rwd)\b/i
#car type
    @typeRegex = /\b(?:sedan|coupe|hatchback|station|suv)\b/i
#transmission
    @transmissionRegex = /\b(?:auto|manual|steptronic)\b/i
#status
    @statusRegex = /\b(?:used|new)\b/i
#carMarker
    @carmakerRegex = /\b(?:honda|toyota|mercedes|bmw|lexus)\b/i
#trim
    @trimRegex = /,(\D{2})\W/i
#fuel economy
    @fuelEcomRegex = /\d*\.?\dl\/100km/i
#year
    @yearRegex = /,(\d{4})\W/i
#stock
    @stockRegex = /\b(?!km)\b\d+[a-z0-9]+\d+[0-9a-z]+(?<!km)\w\b(?<!km)\b/i
#model
    @modelRegex = /\b(?!,).*(?<!,)\b/

#applies the regex patterns for each group and prints
    @features = @@inventory.scan(@featuresRegex)
    @km = @@inventory.scan(@kmRegex)
    @driveTrain = @@inventory.scan(@driveTrainRegex)
    @type = @@inventory.scan(@typeRegex)
    @transmission = @@inventory.scan(@transmissionRegex)
    @status = @@inventory.scan(@statusRegex)
    @carMaker = @@inventory.scan(@carmakerRegex)
    @trim = @@inventory.scan(@trimRegex).flatten
    @fuelEcom = @@inventory.scan(@fuelEcomRegex)
    @year = @@inventory.scan(@yearRegex).flatten
    @stockNumber = @@inventory.scan(@stockRegex)

#combine all arrays into one so we can find what has not be found using regex --> this will be the car models
    @everything = @features + @km + @driveTrain + @type +
        @transmission + @status + @carMaker + @trim + @fuelEcom + @year + @stockNumber

#do a union between the text file string and everything found using regex to find the remaining models
    @missing = @@inventory.gsub(Regexp.union(@everything), '')
#regex to remove unwanted symbols from car models
    @models = @missing.scan(@modelRegex)

#create car_maker objects here

    @manufacturers = @carMaker.map {
        |makers|
      CarMaker.new(makers)
    }

#for every maker, we create a carModel object that is a sub-class of CarMaker

    i = 0
    @manufacturers.each do |cars|
      cars.createModel(@models[i], @trim[i], @km[i], @year[i], @type[i], @driveTrain[i], @transmission[i], @stockNumber[i], @status[i], @fuelEcom[i], @features[i])
      i += 1
    end

  end

  def printCar
    @manufacturers.each do |cars|
      cars.print()

    end
  end

  ## add2 inventory method, this takes an string input, adds it to the original inventory file
  ## it then repeats the same process as convertListings2Catalougue to parse and add it to the inventory system / CarMaker and CarModel objects

  def add2Inventory(inventoryInput)

    File.open(@@inventoryFilePath, 'a+') { |f|
      f.puts inventoryInput

    }

    @@inventory = File.read(@@inventoryFilePath)
    @@inventory = @@inventory.gsub /^@\n/, ''
    # features
    @featuresRegex = /\{.*\}/i
    #km
    @kmRegex = /(?<=\A|,)\d*km/i
    #drive train
    @driveTrainRegex = /\b(?:awd|fwd|rwd)\b/i
    #car type
    @typeRegex = /\b(?:sedan|coupe|hatchback|station|suv)\b/i
    #transmission
    @transmissionRegex = /\b(?:auto|manual|steptronic)\b/i
    #status
    @statusRegex = /\b(?:used|new)\b/i
    #carMarker
    @carmakerRegex = /\b(?:honda|toyota|mercedes|bmw|lexus)\b/i
    #trim
    @trimRegex = /,(\D{2})\W/i
    #fuel economy
    @fuelEcomRegex = /\d*\.?\dl\/100km/i
    #year
    @yearRegex = /,(\d{4})\W/i
    #stock
    @stockRegex = /\b(?!km)\b\d+[a-z0-9]+\d+[0-9a-z]+(?<!km)\w\b(?<!km)\b/i
    #model
    @modelRegex = /\b(?!,).*(?<!,)\b/

    #applies the regex patterns for each group and prints
    @features = @@inventory.scan(@featuresRegex)
    @km = @@inventory.scan(@kmRegex)
    @driveTrain = @@inventory.scan(@driveTrainRegex)
    @type = @@inventory.scan(@typeRegex)
    @transmission = @@inventory.scan(@transmissionRegex)
    @status = @@inventory.scan(@statusRegex)
    @carMaker = @@inventory.scan(@carmakerRegex)
    @trim = @@inventory.scan(@trimRegex).flatten
    @fuelEcom = @@inventory.scan(@fuelEcomRegex)
    @year = @@inventory.scan(@yearRegex).flatten
    @stockNumber = @@inventory.scan(@stockRegex)

    #combine all arrays into one so we can find what has not be found using regex --> this will be the car models
    @everything = @features + @km + @driveTrain + @type +
        @transmission + @status + @carMaker + @trim + @fuelEcom + @year + @stockNumber

    #do a union between the text file string and everything found using regex to find the remaining models
    @missing = @@inventory.gsub(Regexp.union(@everything), '')
    #regex to remove unwanted symbols from car models
    @models = @missing.scan(@modelRegex)

    #create car_maker objects here

    @manufacturers = @carMaker.map {
        |makers|
      CarMaker.new(makers)
    }

    #for every maker, we create a carModel object that is a sub-class of CarMaker

    i = 0
    @manufacturers.each do |cars|
      cars.createModel(@models[i], @trim[i], @km[i], @type[i], @year[i], @driveTrain[i], @transmission[i], @stockNumber[i], @status[i], @fuelEcom[i], @features[i])
      i += 1
    end

  end


  ## this saves the current inventory system, creates a new file and gives it a name based on the current time/date
  # calls the stringify method from the class to produce a string to output to the file
  def saveCatalogue2File()
    write = File.open('inventory-updated ' + Time.now.to_s + ".txt", 'w')
    @strings = []
    @manufacturers.each do |cars|
      carInfo = cars.stringify()
      @strings.push(carInfo)

    end
    write.puts @strings.sort

    write.close
  end

  #Search inventory method
  #this method takes a hash and finds it and then uses it to search for that term
  # I did not implement searching by features as features were not meant to be parsed, nor did i search by KM or fuel economy
  # i thought this would not be revelant search items, and also given the instructions of the assignment I was not sure
  # if we were suppose to just search by car_maker only, so i figured I will implement search for everything I felt
  # I would want as a search item in a inventory system!
  def searchInventory(options = {})
    car_maker = options.fetch(:car_maker, 'BAD ENTRY')
    car_model = options.fetch(:car_model, 'BAD ENTRY')
    car_trim = options.fetch(:car_trim, 'BAD ENTRY')
    car_status = options.fetch(:car_status, 'BAD ENTRY')
    car_transmission = options.fetch(:car_transmission, 'BAD ENTRY')
    car_drive_train = options.fetch(:car_drive_train, 'BAD ENTRY')
    car_type = options.fetch(:car_type, 'BAD ENTRY')
    car_ID = options.fetch(:car_ID, 'BAD ENTRY')
    car_year = options.fetch(:car_year, 'BAD ENTRY')

    #giant if/ statement to see what is being searched matches any of the parameters of a carMaker/ CarModel object
    # by looping through an array of objects
    # counter is used to determine if anything came back from the search, if nothing did it will stay 0 and print a statement saying sorry!
    count = 0
    @manufacturers.each do |cars|
      if (cars.car_maker == car_maker)
        cars.print()

        count += 1
      else
        if (cars.model == car_model)
          cars.print()

          count += 1
        else
          if (cars.trim == car_trim)
            cars.print()
            count += 1

          else
            if (cars.status == car_status)
              cars.print()
              count += 1

            else
              if (cars.trans == car_transmission)
                cars.print()
                count += 1

              else
                if (cars.driveTrain == car_drive_train)
                  cars.print()
                  count += 1

                else
                  if (cars.type == car_type)
                    cars.print()
                    count += 1

                  else
                    if (cars.id == car_ID)
                      cars.print()
                      count += 1
                    else
                      if (cars.year == car_year)
                        cars.print()
                        count += 1
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if (count == 0)
      puts "Sorry we do not have any in stock..."
    end
  end

end

##test functions
# what I left uncommented demos converting the listing, searching
# you can uncomment to add a listing and save to file
# the  new listing will be added as is to the original file
# the save to file will then now include the new listing, parsed properly and also sorted
# i included textfiles already showing this if you want to see those as well
showroom = AutoInventoryDriver.new

showroom.convertListings2Catalougue("inventory.txt")

showroom.printCar()

showroom.searchInventory(car_maker: 'Honda')
showroom.searchInventory(car_model: 'CRV')
showroom.searchInventory(car_trim: 'LX')
showroom.searchInventory(car_year: '2017')
showroom.searchInventory(car_drive_train: 'AWD')
showroom.searchInventory(car_transmission: 'auto')
# showroom.add2Inventory("coupe,100km,auto,RWD, Lexus,CLK,LX ,18F724A,2015,{AC, Heated Seats, Heated Mirrors, Keyless Entry, Power seats},6L/100km,Used")
# showroom.saveCatalogue2File()

