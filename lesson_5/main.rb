require_relative 'modules/manufacturer_name'
require_relative 'modules/instance_counter'
require_relative 'train'
require_relative 'vagon'
require_relative 'cargo_train'
require_relative 'passanger_train'
require_relative 'passanger_vagon'
require_relative 'cargo_vagon'
require_relative 'station'
require_relative 'route'
require_relative 'controller'

controller = Controller.new 
#controller.help
#controller.run

train_1 = CargoTrain.new('123')
train_2 = CargoTrain.new('321')
train_3 = CargoTrain.new('444')
train_4 = CargoTrain.new('3')

st_1 = Station.new('sds')
st_2 = Station.new('5454')

route_1 = Route.new(st_1, st_2)


p Train.instances
p Station.instances
p Route.instances
p CargoTrain.instances
