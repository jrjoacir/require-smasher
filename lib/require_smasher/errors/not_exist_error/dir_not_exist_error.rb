# Define class for handle errors about inexistent directory

class DirNotExistError < NotExistError
  def initialize(message = 'Directory does not exist')
    super(message)
  end
end
