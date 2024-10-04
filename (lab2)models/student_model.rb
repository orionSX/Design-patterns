module StudentValidator



  def phone_valid?(phone)
    !!(phone.to_s =~ /\A\+?\d{10,15}\z/) || phone.nil? || phone.to_s==""
  end

  def fio_valid?(fname,sname,lname)
    !!(fname.to_s =~  /\A[a-zA-Zа-яА-ЯёЁ'-]{1,50}\z/)&&!!(sname.to_s =~  /\A[a-zA-Zа-яА-ЯёЁ'-]{1,50}\z/)&&!!(lname.to_s =~  /\A[a-zA-Zа-яА-ЯёЁ'-]{1,50}\z/)
  end

  def email_valid?(email)

    !!(email.to_s =~  /\A[\w\-.]+@[a-zA-Z\d\-.]+\.[a-zA-Z]{2,}\z/) || email.nil? || email.to_s==""
  end

  def git_valid?(git)

    !!(git.to_s=~/\A(https:\/\/)?(www\.)?github.com\/[a-zA-Z0-9_-]\z/) || git.nil? || git.to_s==""
  end

  def tg_valid?(tg)
    !!(tg.to_s=~/\A@[a-zA-Z0-9_]{5,32}\z/) || tg.nil? || tg.to_s==""
  end

  
end

class Student
  extend StudentValidator

  @@id=0

  attr_accessor :id,:surname,:first_name,:last_name,:phone,:tg,:email,:git
 

  def initialize(first_name:,surname:,last_name:,phone: nil,tg: nil, git: nil,email:nil)
    self.set_fio(first_name,surname,last_name)
    self.phone=phone.to_s
    self.tg=tg.to_s
    self.git=git.to_s
    self.email=email.to_s
    self.id=@@id
    @@id+=1

  end

  def to_s
    instance_variables.map do |key|
      val = instance_variable_get(key)
     
      key_name = key.to_s.delete_prefix('@') 
      "#{key_name} : #{val}" unless val.nil? || val ==""
    end.compact.join("\n") 
  end

  def email=(value)    
    
    Student.email_valid?(value) ?  @email=value.to_s : raise("Incorrect email #{value}")
  end
  def tg=(value)    
    Student.tg_valid?(value) ?  @tg=value.to_s : raise("Incorrect tg #{value}")
  end
  def git=(value)    
    Student.git_valid?(value) ?  @git=value.to_s : raise("Incorrect git #{value}")
  end
  def phone=(value)    
    Student.phone_valid?(value) ?  @phone=value.to_s : raise("Incorrect phone #{value}")
  end

  def set_fio(first_name,surname,last_name)    
    Student.fio_valid?(first_name,surname,last_name) ?  [@first_name=first_name.to_s , @surname=surname.to_s , @last_name=last_name.to_s]  : raise("Incorrect fio")
  end


end


