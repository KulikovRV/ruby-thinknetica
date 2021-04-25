# frozen_string_literal: true

class Route
  include InstanceCounter
  include CheckValid

  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
    @start = start
    @finish = finish
    validation!
    register_instance
  end

  def add_intermediate_station(intermediate_station)
    @stations.insert(-2, intermediate_station)
  end

  def delete_intermediate_station(intermediate_station)
    return if intermediate_station == @start && intermediate_station == @finish

    @stations.delete(intermediate_station)
  end

  def name
    "#{stations.first.title}-#{stations.last.title}"
  end

  def valid?
    validation
  rescue StandardError
    false
  end

  def validation!
    raise 'Вы добавили не сущетсвующую станцию в маршрут.' if start.nil?
    raise 'Вы добавили не сущетсвующую станцию в маршрут.' if finish.nil?

    true
  end

  private

  attr_reader :start, :finish
end
