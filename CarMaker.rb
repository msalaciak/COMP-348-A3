
class CarMaker
  @@counter = 0
  attr_accessor :car_maker, :listing
  attr_writer :listing

  def initialize(maker)

    self.car_maker = maker
    @@counter += 1

  end


  def createModel(model, trim, km, year,type, driveTrain, trans, id, status, fuel, features)
    @carModel = CarModel.new(model, trim, km, year,type, driveTrain, trans, id, status, fuel, features)

  end


  def print()
    puts self.car_maker + "," + @carModel.print().to_s

  end

  def stringify()
    listing = self.car_maker + "," + @carModel.print().to_s

  end



end

### CarModel class

class CarModel < CarMaker


  attr_accessor :model, :trim, :km, :year ,:type ,:driveTrain ,:trans,:id,:status,:fuel,:features
  attr_writer :model, :trim, :km, :year ,:type,:driveTrain ,:trans,:id,:status,:fuel,:features

  def initialize(model, trim, km, year, type, driveTrain, trans, id, status, fuel, features)
    self.model = model
    self.trim = trim
    self.km = km
    self.year = year
    self.type = type;
    self.driveTrain = driveTrain
    self.trans = trans
    self.id = id
    self.status = status
    self.fuel = fuel
    self.features = features

  end

  def print()

    self.model + "," + self.trim + "," + self.km + "," + self.year + "," + self.type + "," + self.driveTrain +
             "," + self.trans + "," + self.id + "," + self.status + "," + self.fuel + "," + self.features


  end



end