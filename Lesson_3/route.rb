require_relative 'station'
require_relative 'train'

class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
    @start = start
    @finish = finish
  end

  def add_intermediate_station(intermediate_station)
    @stations.insert(-2, intermediate_station)
  end

  def delete_intermediate_station(intermediate_station)
    if (intermediate_station == @start || intermediate_station == @finish)
      puts "Невозможно удалить стартовую или финишную станцию."
    else  
      @stations.delete(intermediate_station)
    end  
  end
end  
