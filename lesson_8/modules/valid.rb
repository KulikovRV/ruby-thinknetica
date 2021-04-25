# frozen_string_literal: true

module CheckValid
  def valid?
    validation
  rescue StandardError
    false
  end
end
