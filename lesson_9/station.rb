# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :title

  validate :title, :presence

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(title)
    @title = title
    @trains = []
    validate!
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
    @trains.count { |train| train.type == type }
  end

  def train_bypass
    trains.each { |train| yield(train) }
  end
end
