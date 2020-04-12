# used Regular Expressions Cookbook 2nd edition and www.regex101.com for inspiriaton and help

def inventoryParser(textFile)
  if not File.exist?(textFile) or File.zero?(textFile)
    abort "Sorry the file you inputted is either missing or empty, please check the file path"
  else

    inventory = File.read(textFile)
    inventory = inventory.gsub /^$\n/, ''
  end

  puts "#{inventory}"


# all the regex patterns to parse the auto inventory textfile
# features
  $featuresRegex =  /\{.*\}/i
#km
  $kmRegex = /(?<=\A|,)\d*km/i
#drive train
  $driveTrainRegex = /\b(?:awd|fwd|rwd)\b/i
#car type
  $typeRegex = /\b(?:sedan|coupe|hatchback|station|suv)\b/i
#transmission
  $transmissionRegex = /\b(?:auto|manual|steptronic)\b/i

#status
  $statusRegex =  /\b(?:used|new)\b/i

#carMarker
  $carmakerRegex =  /\b(?:honda|toyota|mercedes|bmw|lexus)\b/i

#trim
  $trimRegex = /,(\D{2})\W/i

#fuel economy
  $fuelEcomRegex = /\d*\.?\dl\/100km/i

#year
  $yearRegex = /,(\d{4})\W/i

#stock
  $stockRegex = /\b(?!km)\b\d+[a-z0-9]+\d+[0-9a-z]+(?<!km)\w\b(?<!km)\b/i

#model
  $modelRegex = /\b(?!,).*(?<!,)\b/

#applies the regex patterns for each group and prints
#
  $features = inventory.scan($featuresRegex)
  puts "#{ $features}"

  $km = inventory.scan($kmRegex)
  puts "#{ $km}"

  $driveTrain = inventory.scan($driveTrainRegex)
  puts "#{ $driveTrain}"

  $type = inventory.scan($typeRegex)
  puts "#{ $type}"

  $transmission = inventory.scan($transmissionRegex)
  puts "#{ $transmission}"

  $status = inventory.scan($statusRegex)
  puts "#{ $status}"

  $carMaker = inventory.scan($carmakerRegex)
  puts "#{ $carMaker}"

  $trim = inventory.scan($trimRegex).flatten
  puts "# ${trim}"

  $fuelEcom = inventory.scan($fuelEcomRegex)
  puts "#{ $fuelEcom}"

  $year = inventory.scan($yearRegex).flatten
  puts "#{ $year}"

  $stockNumber = inventory.scan($stockRegex)

  puts "#{ $stockNumber}"

  $everything =  $features +  $km +  $driveTrain +  $type +
      $transmission +  $status +  $carMaker +  $trim +  $fuelEcom +  $year +  $stockNumber

  $missing = inventory.gsub(Regexp.union($everything),'')

  $models =  $missing.scan($modelRegex)

  puts  "#{$models}"

  $organizedInventory = []
  $organizedInventory.push($features)
  $organizedInventory.push($km)

  return $organizedInventory
end

newInventory = inventoryParser("inventory.txt")


newInventory.each do |sub_array|
  sub_array.each do |item|
    puts item
  end
end
