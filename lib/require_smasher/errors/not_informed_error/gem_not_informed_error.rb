# Define class for handle error when a gem is not informed

class GemNotInformedError < NotInformedError
  def initialize(message = 'Gem was not informed')
    super(message)
  end
end
