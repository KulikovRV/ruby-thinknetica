class PassangerTrain < Train
  TYPE = "passanger"
  
  def initialize(name)
    super(name, TYPE)
  end

  def hook_vagon(vagon)
    super(vagon) if vagon.class == PassangerVagon
  end
end
