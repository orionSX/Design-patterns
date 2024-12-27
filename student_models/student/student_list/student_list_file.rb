
require 'json'
require 'yaml'
require_relative '../../../data_models/data_list_student_short.rb'
require_relative '../filters/filters.rb'

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

  def get_student(id)
    @students.find { |student| student.id == id }
  end

  def get_k_n_student_short_list(k, n, data_list = nil,filters=[])
    start_index = (k - 1) * n

    filter_sequence=FilterDecorator.new(filters)
    filtered_students=filter_sequence.apply(@students)
    selected_students =filtered_students[start_index, start_index+n] || []
    
    short_list = selected_students.map do |student|
      StudentShort.new(student)
      end
    data_list || DataListStudentShort.new(short_list,start_index)
  end


  def add_student(student)
    student.id = next_id
    @students << student
    write_all
  end

  def update_student(id, new_student)
    index = @students.find_index { |student| student.id == id }
    raise IndexError,'out of range' unless index

    @students[index] = new_student
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
