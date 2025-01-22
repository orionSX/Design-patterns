
class FileStrategy
  def self.read(file_path)
    raise NotImplementedError, 'Method must be implemented in a subclass'
  end

  def self.write(file_path, data)
    raise NotImplementedError, 'Method must be implemented in a subclass'
  end
end
