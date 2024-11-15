require_relative 'data_list.rb'
class DataListStudentShort < DataList
  def get_names
    ['№', 'FIO', 'git','contact']
  end

  def get_data
    data = self.selected.map.with_index do |item, index|
      [index, item.FIO, item.git,item.contact]
    end
    data
  end

end



