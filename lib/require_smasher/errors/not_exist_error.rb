# frozen_string_literal: true

# Define super class for handle errors about elements that do not exist

class NotExistError < BaseError
  def initialize(message)
    super(message)
  end
end
