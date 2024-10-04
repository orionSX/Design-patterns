require_relative "student_model"


st1=Student.new(surname:"A",first_name:"B",last_name:"C")

st2=Student.new(surname:"D",first_name:"E",last_name:"F",email:"cheta@gde.to",phone: "")
puts st1.to_s
puts "--------"
puts st2.to_s