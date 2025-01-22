require_relative 'file_base.rb'
class YAMLStrategy < FileStrategy
  def self.read(file_path)
    x=File.exist?(file_path) ? YAML.load_file(file_path) : []
    normalized=[]
    x.map do |el|

    normalized_h=el.transform_keys(&:to_sym)
    normalized << normalized_h
    end
    normalized
  end

  def self.write(file_path, data)
    File.write(file_path, data.to_yaml)
  end
end
