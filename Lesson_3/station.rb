require_relative 'train'
require_relative 'route'

class Station
  attr_reader :trains

  def initialize(title)
    @title = title
    @trains = []
  end

  def take_the_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

  def show_type_of_trains(type)
    @trains.count { |train| train.type == type}
  end
end
