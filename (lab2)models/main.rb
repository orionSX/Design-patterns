require_relative "student_model"
st4_info={
   id:2, surname:"ZXC",first_name:"ASD",last_name:"FFFF",phone: "12345678910",git:"https://github.com/orionSX"
}

st1=Student.new(surname:"A",first_name:"B",last_name:"C")

st2=Student.new(surname:"SDASDAS",first_name:"E",last_name:"F",email:"cheta@gde.to")
st3=Student.new(surname:"D",first_name:"E",last_name:"F",email:"cheta@gde.to")
st4=Student.new(**st4_info)


st4_s=StudentShort.new(student:st4)

puts st4_s.validate