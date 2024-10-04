class Student
  attr_accessor :id,:surname,:first_name,:last_name,:phone,:tg,:email,:git

  def initialize(first_name:,surname:,last_name:,phone: nil,tg: nil, git: nil,email:nil,id:nil)
    self.first_name=first_name
    self.surname=surname
    self.last_name=last_name
    self.phone=phone
    self.tg=tg
    self.git=git
    self.email=email
    self.id=id
  end

  def to_s
    instance_variables.map do |key|
      val = instance_variable_get(key)
      key_name = key.to_s.delete_prefix('@') 
      "#{key_name} : #{val}" unless val.nil? 
    end.compact.join("\n") 
  end

  def Student.is_phone?(phone)
    !!(phone.to_s =~ /\A\+?\d{10,15}\z/)    
  end

  def phone=(value) 
    @phone=nil   
    Student.is_phone?(value) ?  @phone=value.to_s : raise("Incorrect phone #{value}") unless value.nil? || value.to_s==""
  end


end


