require_relative "student/student_model.rb"
require_relative "student/student_short.rb"
require_relative "student/BST.rb"
students = [
  { surname: "A", first_name: "B", last_name: "C", date_of_birth: '10.03.2000' },
  { surname: "SDASDAS", first_name: "E", last_name: "F", date_of_birth: '25.06.2002' },
  { surname: "D", first_name: "E", last_name: "F", date_of_birth: '15.08.1998' },
  { surname: "ZXC", first_name: "ASD", last_name: "FFFF", date_of_birth: '30.03.2004' },
  { surname: "QWE", first_name: "Q", last_name: "R", date_of_birth: '12.12.2001' },
  { surname: "RTY", first_name: "T", last_name: "Y", date_of_birth: '11.11.1997' },
  { surname: "ASD", first_name: "S", last_name: "D", date_of_birth: '20.02.2000' },
  { surname: "FGH", first_name: "F", last_name: "H", date_of_birth: '22.10.1999' },
  { surname: "VBN", first_name: "V", last_name: "B", date_of_birth: '15.04.1995' },
  { surname: "QAZ", first_name: "Z", last_name: "X", date_of_birth: '17.07.2003' }
]

student_objects = students.map do |info|
  student = Student.new(**info)
 
end
tree = BinaryStudentTree.new
student_objects.each do |student|
   
   tree.add_student(student)
 end
tree.each(type: :BFS){|x| puts x.date_of_birth}
