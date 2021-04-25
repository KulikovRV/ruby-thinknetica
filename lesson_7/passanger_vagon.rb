class PassangerVagon < Vagon
  
  attr_reader :occupied_places, :places

  TYPE = "passanger"

  @@number = 0

  def initialize(places)
    @places = places
    @occupied_places = 0
    @type = TYPE
    @@number += 1
    @number = @@number
  end 
  
  def take_the_place
    @occupied_places += 1
  end

  def count_empty_seats
    places - occupied_places
  end 
end
