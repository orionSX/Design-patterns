require_relative "student/student_model.rb"
require_relative "student/student_short.rb"
require_relative "student/BST.rb"
require_relative 'student/file_strategy/file_json.rb'
require_relative 'student/file_strategy/file_yaml.rb'
require_relative "student/student_list/student_list_base.rb"



json_list=StudentsListBase.new('students.json',JSONStrategy)
yaml_list=StudentsListBase.new('students.yaml',YAMLStrategy)
yaml_list.delete_student(1)
puts yaml_list.students
