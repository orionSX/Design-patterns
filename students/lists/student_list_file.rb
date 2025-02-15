
require 'json'
require 'yaml'
require_relative 'data_list_student_short.rb'
require_relative '../models/student_short.rb'
require_relative 'filters.rb'

class StudentsListBase
  attr_reader :students

  def initialize(file_path,strategy)
    @file_path = file_path
    @students = []
    @strategy=strategy
    read_all
  end

  def read_all
    data = @strategy.read(@file_path)
    @students = data.map { |entry| Student.new(**entry) }
  end

  def write_all
    @strategy.write(@file_path, @students.map(&:to_h))
  end
  def sort_by_fio!
    @students.sort_by! { |student| student.get_fio }
  end
  def get_student(id)
    @students.find { |student| student.id == id }
  end

  def get_k_n_student_short_list(k, n, data_list =nil,filters=[])
    start_index = (k - 1) * n

    filter_sequence=FilterDecorator.new(filters)    

    
    selected_students = @students[start_index, start_index+n] || []
    
    short_list = selected_students.map do |student|
      StudentShort.new(student:student)
      end
    data_list ||= DataListStudentShort.new(short_list,start_index)
    data_list
  end


  def add_student(student)
    @students.each do |st|
      if !st.phone.nil? && st.phone==student.phone || !st.tg.nil? && st.tg==student.tg || !st.email.nil? && st.email==student.email || !st.git.nil? && st.git==student.git
        raise "Contact exists"
      end
    end
    student.id = next_id
    @students << student
    write_all
  end

  def update_student(id, student)
    index = @students.find_index { |student| student.id == id }
    raise IndexError,'out of range' unless index

    @students.each do |st|
      if !st.phone.nil? && st.phone==student.phone || !st.tg.nil? && st.tg==student.tg || !st.email.nil? && st.email==student.email || !st.git.nil? && st.git==student.git
        raise "Contact exists"
      end
    end
    @students[index] = student
    write_all
    
  end

  def delete_student(id)
    @students.reject! { |student| student.id == id }
    write_all
  end

  def student_count
    @students.size
  end

  private

  def next_id
    max_id = @students.map(&:id).max || 0
    max_id + 1
  end
end
