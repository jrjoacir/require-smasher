# frozen_string_literal: true

# Define super class for handle errors about elements that were not informed

class NotInformedError < BaseError
  def initialize(message)
    super(message)
  end
end
