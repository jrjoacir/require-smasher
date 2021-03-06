# frozen_string_literal: true

# Define base class for handle errors

class BaseError < StandardError
  def initialize(message)
    super(message)
  end
end
