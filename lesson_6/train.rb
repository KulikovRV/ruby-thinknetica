class Train
  include ManufacturerName
  include InstanceCounter
  include CheckValid

  attr_reader :number, :type, :speed, :vagons, :route
  
  NUMBER_FORMAT = /^[a-z\d]{3}((-)?[a-z\d]{2})$/i
  @@trains = {}
  
  def self.find(number) 
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @vagons = []
    @type = type
    @speed = 0
    @station_index = 0
    validation!
    @@trains[number] = self
    register_instance
  end
  
  def take_route(route)
    @station_index = 0
    @route = route
    @route.stations[@station_index].take_the_train(self)
  end

  def increase_speed
    @speed += 20
  end
  
  def slow_down
    @speed = 0
  end  

  def hook_vagon(vagon)
    @vagons << vagon if @speed == 0 
  end

  def unhook_vagon
    @vagons.pop if @speed == 0
  end

  def show_previous_station
    @route.stations[@station_index - 1]
  end

  def show_current_station
    @route.stations[@station_index] 
  end

  def show_next_station
    @route.stations[@station_index + 1]
  end

  def go_next_station
    if show_current_station != @route.stations.last
      show_current_station.departure_train(self)
      @station_index += 1
      show_current_station.take_the_train(self)
    end
  end

  def go_previous_station
    if show_current_station != @route.stations.first
      show_current_station.departure_train(self)
      @station_index -= 1
      show_current_station.take_the_train(self)
    end
  end

  def valid?
    validation
  rescue
    false
  end

  def validation!
    raise "Неправильный формат номера." if number !~ NUMBER_FORMAT
    raise "Неверный тип поезда" if type != 'cargo' || type != 'passanger'
    true
  end    
end   
