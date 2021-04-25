# frozen_string_literal: true

class CargoTrain < Train
  TYPE = 'cargo'

  validate :number, :format, /^[a-z\d]{3}((-)?[a-z\d]{2})$/i.freeze

  def initialize(number)
    super(number, TYPE)
  end

  def hook_vagon(vagon)
    super(vagon) if vagon.class == CargoVagon
  end
end
