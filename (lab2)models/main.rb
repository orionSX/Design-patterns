require_relative "student_model"
st4_info={
    surname:"ZXC",first_name:"ASD",last_name:"FFFF",email:"chXDXDXDeta@gde.to",phone: "12345678910"
}

st1=Student.new(surname:"A",first_name:"B",last_name:"C")

st2=Student.new(surname:"SDASDAS",first_name:"E",last_name:"F",email:"cheta@gde.to")
st3=Student.new(surname:"D",first_name:"E",last_name:"F",email:"cheta@gde.to",phone: "")
st4=Student.new(**st4_info)
puts st1.to_s
puts "--------"
puts st4.to_s
