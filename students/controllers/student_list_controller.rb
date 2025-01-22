
require_relative '../lists/student_list_file.rb'
require_relative '../lists/data_list_student_short.rb'
require_relative '../lists/file_strategy/file_json.rb'

class StudentListController

def initialize(view)
    self.view = view
    self.student_list = StudentsListBase.new('D:\Github\JUK\students\controllers\students.json', JSONStrategy)
 
    self.data_list = DataListStudentShort.new([])
    self.data_list.add_observer(self.view)
end


def sort_table_by_column
    self.student_list.sort_by_fio!
    self.data_list.notify(self.data)
end

def refresh_data
    self.data = self.student_list.get_k_n_student_short_list(self.view.current_page_label, self.view.class::ROWS_PER_PAGE)

    self.data_list.count = self.student_list.student_count
    self.data_list.notify(self.data)
end


def add
end


def delete(indexes)
     puts "Удаление записей с индексами #{indexes}"
end


def update(index)
    puts "Изменение записи с индексом: #{index}"
end


private
attr_accessor :view, :student_list, :data_list, :data

end