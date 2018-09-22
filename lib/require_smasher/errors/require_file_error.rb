# Define class for handle error when a file is required

class RequireFileError < BaseError
  def initialize(message)
    super(message)
  end
end
