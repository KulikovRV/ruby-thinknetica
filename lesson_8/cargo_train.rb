# frozen_string_literal: true

class CargoTrain < Train
  TYPE = 'cargo'

  def initialize(number)
    super(number, TYPE)
  end

  def hook_vagon(vagon)
    super(vagon) if vagon.class == CargoVagon
  end
end
