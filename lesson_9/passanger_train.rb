# frozen_string_literal: true

class PassangerTrain < Train
  TYPE = 'passanger'

  def initialize(number)
    super(number, TYPE)
  end

  def hook_vagon(vagon)
    super(vagon) if vagon.class == PassangerVagon
  end
end
