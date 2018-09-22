# Define class for handle error when a file is not informed

class FileNotInformedError < NotInformedError
  def initialize(message = 'File was not informed')
    super(message)
  end
end
