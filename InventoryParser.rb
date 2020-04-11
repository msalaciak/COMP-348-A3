module InventoryParser
# used Regular Expressions Cookbook 2nd edition and www.regex101.com for inspiriaton and help

  def inventoryParser(textFile)
    if not File.exist?(textFile) or File.zero?(textFile)
      abort "Sorry the file you inputted is either missing or empty, please check the file path"
    else

      inventory = File.read(textFile)
      inventory = inventory.gsub /^$\n/, ''
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

    @features = inventory.scan(@featuresRegex)


    @km = inventory.scan(@kmRegex)


    @driveTrain = inventory.scan(@driveTrainRegex)


    @type = inventory.scan(@typeRegex)


    @transmission = inventory.scan(@transmissionRegex)


    @status = inventory.scan(@statusRegex)


    @carMaker = inventory.scan(@carmakerRegex)


    @trim = inventory.scan(@trimRegex).flatten


    @fuelEcom = inventory.scan(@fuelEcomRegex)


    @year = inventory.scan(@yearRegex).flatten


    @stockNumber = inventory.scan(@stockRegex)


#combine all arrays into one so we can find what has not be found using regex --> this will be the car models
    @everything =  @features +  @km +  @driveTrain +  @type +
        @transmission +  @status +  @carMaker +  @trim +  @fuelEcom +  @year +  @stockNumber

#do a union between the text file string and everything found using regex to find the remaining models
    @missing = inventory.gsub(Regexp.union(@everything),'')

#regex to remove unwanted symbols from car models
    @models =  @missing.scan(@modelRegex)

#put everything into a 2d array and return it for processing
    @organizedInventory = []
    @organizedInventory.push(@features)
    @organizedInventory.push(@km)
    @organizedInventory.push(@driveTrain)
    @organizedInventory.push(@type)
    @organizedInventory.push(@transmission)
    @organizedInventory.push(@status)
    @organizedInventory.push(@carMaker)
    @organizedInventory.push(@trim)
    @organizedInventory.push(@fuelEcom)
    @organizedInventory.push(@year)
    @organizedInventory.push(@stockNumber)
    @organizedInventory.push(@models)

    return @organizedInventory
  end

end