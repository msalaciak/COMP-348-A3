load 'InventoryParser.rb'

class AutoInventoryDriver
  include InventoryParser

end

test = AutoInventoryDriver.new

newInventory = test.inventoryParser("inventory.txt")
newInventory.each do |sub_array|
  sub_array.each do |item|
    puts item
  end
end
