require_relative 'station'
require_relative 'route'
  
class Train
  attr_reader :name, :type, :speed, :vagons

  def initialize(name, type, vagons)
    @name = name
    @type = type
    @vagons = vagons
    @speed = 0
    @station_index = 0
  end

  def increase_speed
    @speed += 20
  end
  
  def slow_down
    @speed = 0
  end  

  def hook_vagon
    @vagons += 1 if @speed == 0 
  end

  def unhook_vagon
    @vagons -= 1 if @speed == 0
  end

  def take_route(route)
    @station_index = 0
    @route = route
    @route.stations[@station_index].take_the_train(self)
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
end   
