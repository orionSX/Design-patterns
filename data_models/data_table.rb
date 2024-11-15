require_relative 'deep_copy.rb'
class DataTable
  def initialize(data)
    raise ArgumentError, 'Data must be a 2D array' unless data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
    @data = data
  end

  def get_element(row, col)
    raise ArgumentError, 'Invalid row or column' unless valid_index?(row, col)
    DeepCopy.copy(@data[row][col])
  end

  def rows_count
    @data.size
  end

  def columns_count
    @data.empty? ? 0 : @data[0].size
  end

  attr_reader :data
  private


  def valid_index?(row, col)
    row >= 0 && row < @data.size && col >= 0 && col < @data[row].size
  end
end
