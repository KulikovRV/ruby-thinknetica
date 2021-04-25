class Station
  include InstanceCounter
  include CheckValid
  
  attr_reader :trains, :title

  @@stations = []

  def self.all
    @@stations  
  end

  def initialize(title)
    @title = title
    @trains = []
    validation!
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
  
  def valid?
    validation
  rescue
    false
  end

  def validation!
    raise "Название станции не содержит символов." if title.length < 1
    true
  end  
  
  def train_bypass
    trains.each {|train| yield(train)}
  end
end
