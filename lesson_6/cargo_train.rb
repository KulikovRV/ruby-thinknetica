class CargoTrain < Train
  TYPE = "cargo"
  
  def initialize(name)
    super(name, TYPE)
  end
  
  def hook_vagon(vagon)
    super(vagon) if vagon.class == CargoVagon
  end
end
