module CheckValid
  def valid?
    validation
  rescue
    false
  end
end
