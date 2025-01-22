require_relative 'deep_copy.rb'
require_relative 'data_table.rb'
class DataList
 attr_accessor :count , :items
  def initialize(items,start_index=0)
    raise ArgumentError, 'Items must be an array' unless items.is_a?(Array)
    @items = items
    @selected = []
    @start_index=start_index
    @observers = []
  end

  def select(number)
    raise ArgumentError, 'Invalid index' unless  number >= 0 && number < @items.size
    @selected << number unless @selected.include?(number)
  end

  def get_selected
    DeepCopy.copy(selected)
  end
  def add_observer(observer)
    @observers << observer
  end
  def proceed_data_table
    dt=[]
    dt << self.get_names
    dt.concat(self.get_data(@start_index))
    DataTable.new(dt)
  end

  def get_names
    raise NotImplementedError, 'get_names must be implemented in a subclass'
  end

  def notify(data)
  
    @observers.each do |observer|
      observer.set_table_params(data.get_names, data.items.size)
      
      observer.set_table_data(DataTable.new(data.get_data))
    end
  end
  def get_data
    raise NotImplementedError, 'get_data must be implemented in a subclass'
  end

  protected
  attr_accessor :selected
end
