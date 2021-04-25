class CargoVagon < Vagon

  attr_reader :total_volume, :occupies_volume

  TYPE = "cargo"

  @@number = 0

  def initialize(total_volume)
    @total_volume = total_volume
    @type = TYPE
    @occupies_volume = 0
    @@number += 1
    @number = @@number
  end 

  def available_volume
    total_volume - occupies_volume
  end

  def take_volume(volume)
    @occupies_volume += volume
  end
end
