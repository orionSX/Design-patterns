
require_relative "student_base.rb"
class Student < StudentBase 
 include Comparable
  attr_reader  :email, :phone, :tg,:first_name,:surname,:last_name,:date_of_birth

  def initialize(first_name:nil, surname:nil, last_name:nil,phone: nil, tg: nil, git: nil, email: nil,id:nil,date_of_birth:nil)
    super(id:id,git:git)
    raise ("FIO required") if (first_name.nil? || surname.nil? ||last_name.nil?)
    @first_name=set_attribute(:first_name,first_name) 
    @surname=set_attribute(:surname,surname)
    @last_name=set_attribute(:last_name,last_name)
    set_date_of_birth(date_of_birth:date_of_birth)
    set_contacts(phone: phone, tg: tg, email: email)   

  end

  def <=>(stud)
    Date.parse(self.date_of_birth) <=> Date.parse(stud.date_of_birth) 
  end

  def set_contacts(phone: nil , tg: nil,  email:nil)
    set_attribute(:phone, phone) if phone
    set_attribute(:tg, tg) if tg
    set_attribute(:email, email) if email
  end
  def set_date_of_birth(date_of_birth:nil)
    set_attribute(:date_of_birth, date_of_birth) if date_of_birth
   
  end

  def set_git(git:nil)
    set_attribute(:git,git) if git
  end

  def change_fio(first_name: nil , last_name: nil,surname:nil)
    set_attribute(:first_name, first_name) if first_name
    set_attribute(:last_name, last_name) if last_name
    set_attribute(:surname, surname) if surname
  end 
 
end



