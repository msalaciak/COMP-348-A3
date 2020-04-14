##A3_29644490 Matthew Salaciak
# this is implementaton of the class CarMaker and sub class CarModel


class CarMaker
  #getters and settings
  @@counter = 0
  attr_accessor :car_maker, :listing, :model, :trim, :km, :year, :type, :driveTrain, :trans, :id, :status, :fuel, :features
  attr_writer :listing, :model, :trim, :km, :year, :type, :driveTrain, :trans, :id, :status, :fuel, :features

  #constructor
  def initialize(maker)

    self.car_maker = maker
    @@counter += 1


  end

  ##creates a CarModel object
  def createModel(model, trim, km, year, type, driveTrain, trans, id, status, fuel, features)
    @carModel = CarModel.new(model, trim, km, year, type, driveTrain, trans, id, status, fuel, features)
    self.model = model
    self.trim = trim
    self.km = km
    self.year = year
    self.type = type
    self.driveTrain = driveTrain
    self.trans = trans
    self.id = id
    self.status = status
    self.fuel = fuel
    self.features = features


  end

  #print method
  def print()
    puts self.car_maker + "," + @carModel.print().to_s

  end
  #this prints the car marker and its carModel objects
  def stringify()
    listing = self.car_maker + "," + @carModel.print().to_s

  end


end

### CarModel class

class CarModel < CarMaker

#getters and setters
  attr_accessor :model, :trim, :km, :year, :type, :driveTrain, :trans, :id, :status, :fuel, :features
  attr_writer :model, :trim, :km, :year, :type, :driveTrain, :trans, :id, :status, :fuel, :features

  #constructor
  def initialize(model, trim, km, year, type, driveTrain, trans, id, status, fuel, features)
    self.model = model
    self.trim = trim
    self.km = km
    self.year = year
    self.type = type
    self.driveTrain = driveTrain
    self.trans = trans
    self.id = id
    self.status = status
    self.fuel = fuel
    self.features = features

  end
  #print method
  def print()

    self.model + "," + self.trim + "," + self.km + "," + self.year + "," + self.type + "," + self.driveTrain +
        "," + self.trans + "," + self.id + "," + self.status + "," + self.fuel + "," + self.features


  end


end