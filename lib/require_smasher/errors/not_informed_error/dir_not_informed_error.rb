# Define class for handle error when a directory is not informed

class DirNotInformedError < NotInformedError
  def initialize(message = 'Directory was not informed')
    super(message)
  end
end
