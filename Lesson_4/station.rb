class Station
  include InstanceCounter
  
  attr_reader :trains, :title

  @@stations = []

  def self.all
    @@stations  
  end

  def initialize(title)
    @title = title
    @trains = []
    @@stations << self
    register_instance
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
