class Route
  include InstanceCounter
  
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
    @start = start
    @finish = finish
    register_instance
  end

  def add_intermediate_station(intermediate_station)
    @stations.insert(-2, intermediate_station)
  end

  def delete_intermediate_station(intermediate_station)
    @stations.delete(intermediate_station) if (intermediate_station != @start && intermediate_station != @finish)
  end

  def name
    "#{stations.first.title}-#{stations.last.title}"
  end
end  
