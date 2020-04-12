require './CarMaker.rb'

class AutoInventoryDriver
  @@inventory =0
  @@inventoryFilePath =0


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
    @featuresRegex =  /\{.*\}/i
#km
    @kmRegex = /(?<=\A|,)\d*km/i
#drive train
    @driveTrainRegex = /\b(?:awd|fwd|rwd)\b/i
#car type
    @typeRegex = /\b(?:sedan|coupe|hatchback|station|suv)\b/i
#transmission
    @transmissionRegex = /\b(?:auto|manual|steptronic)\b/i
#status
    @statusRegex =  /\b(?:used|new)\b/i
#carMarker
    @carmakerRegex =  /\b(?:honda|toyota|mercedes|bmw|lexus)\b/i
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
    @everything =  @features +  @km +  @driveTrain +  @type +
        @transmission +  @status +  @carMaker +  @trim +  @fuelEcom +  @year +  @stockNumber

#do a union between the text file string and everything found using regex to find the remaining models
    @missing = @@inventory.gsub(Regexp.union(@everything),'')
#regex to remove unwanted symbols from car models
    @models =  @missing.scan(@modelRegex)

    #create car_maker objects here


    @manufacturers = @carMaker.map {
        |makers|
      CarMaker.new(makers)
    }



#for every maker, we create a carModel object that is a sub-class of CarMaker

    i = 0
    @manufacturers.each do |cars|
      cars.createModel(@models[i],@trim[i],@km[i],@year[i],@driveTrain[i],@transmission[i], @stockNumber[i],@status[i],@fuelEcom[i],@features[i])
      i +=1
    end



  end

  def printCar
    @manufacturers.each do |cars|
      cars.print()

    end
  end


  #Search inventory method

  def searchInventory(options ={} )
    @options = { "Honda" => "Honda", "Toyota" => "Toyota", "Mercedes" => "Mercedes" ,  "BMW" => "BMW", "Lexus" => "Lexus"}
    car_maker = options.fetch(:car_maker, 'default')

    count =0
    @manufacturers.each do |cars|
      if(cars.car_maker == car_maker)
        cars.print()
        count += 1
      end
    end
    if(count == 0)
      puts "Sorry we do not have any " + car_maker + " in stock..."
    end
  end

  ## add2 inventory method

  def add2Inventory(inventoryInput)

    open(@@inventoryFilePath, 'a') { |f|
      f.puts inventoryInput
    }


    # features
    @featuresRegex =  /\{.*\}/i
#km
    @kmRegex = /(?<=\A|,)\d*km/i
#drive train
    @driveTrainRegex = /\b(?:awd|fwd|rwd)\b/i
#car type
    @typeRegex = /\b(?:sedan|coupe|hatchback|station|suv)\b/i
#transmission
    @transmissionRegex = /\b(?:auto|manual|steptronic)\b/i
#status
    @statusRegex =  /\b(?:used|new)\b/i
#carMarker
    @carmakerRegex =  /\b(?:honda|toyota|mercedes|bmw|lexus)\b/i
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
    @features = inventoryInput.scan(@featuresRegex)
    @km = inventoryInput.scan(@kmRegex)
    @driveTrain = inventoryInput.scan(@driveTrainRegex)
    @type = inventoryInput.scan(@typeRegex)
    @transmission = inventoryInput.scan(@transmissionRegex)
    @status = inventoryInput.scan(@statusRegex)
    @carMaker = inventoryInput.scan(@carmakerRegex)
    @trim = inventoryInput.scan(@trimRegex).flatten
    @fuelEcom = inventoryInput.scan(@fuelEcomRegex)
    @year = inventoryInput.scan(@yearRegex).flatten
    @stockNumber = inventoryInput.scan(@stockRegex)

#combine all arrays into one so we can find what has not be found using regex --> this will be the car models
    @everything =  @features +  @km +  @driveTrain +  @type +
        @transmission +  @status +  @carMaker +  @trim +  @fuelEcom +  @year +  @stockNumber

#do a union between the text file string and everything found using regex to find the remaining models
    @missing = inventoryInput.gsub(Regexp.union(@everything),'')
#regex to remove unwanted symbols from car models
    @models =  @missing.scan(@modelRegex)

#create car_maker objects here


    @manufacturers = @carMaker.map {
        |makers|
      CarMaker.new(makers)
    }



#for every maker, we create a carModel object that is a sub-class of CarMaker

    i = 0
    @manufacturers.each do |cars|
      cars.createModel(@models[i],@trim[i],@km[i],@year[i],@driveTrain[i],@transmission[i], @stockNumber[i],@status[i],@fuelEcom[i],@features[i])
      i +=1
    end


  end

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


end

##test functions
showroom = AutoInventoryDriver.new

showroom.convertListings2Catalougue("inventory-test.txt")


# showroom.printCar()

# showroom.searchInventory(car_maker: 'Honda')

# showroom.searchInventory(({"car_maker" => "Honda"}))

# showroom.add2Inventory("coupe,100km,auto,RWD, Lexus,CLK,LX ,18F724A,2015,{AC, Heated Seats, Heated Mirrors, Keyless Entry, Power seats},6L/100km,Used")

# showroom.printCar()

# showroom.saveCatalogue2File()

