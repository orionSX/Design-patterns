
require_relative "student_base.rb"
class Student < StudentBase 

  attr_reader  :email, :phone, :tg,:first_name,:surname,:last_name

  def initialize(first_name:nil, surname:nil, last_name:nil,phone: nil, tg: nil, git: nil, email: nil,id:nil)
    super(id:id,git:git)
    raise ("FIO required") if (first_name.nil? || surname.nil? ||last_name.nil?)
    @first_name=set_attribute(:first_name,first_name) 
    @surname=set_attribute(:surname,surname)
    @last_name=set_attribute(:last_name,last_name)
    set_contacts(phone: phone, tg: tg, email: email)   

  end

 
  def set_contacts(phone: nil , tg: nil, git:nil, email:nil)
    set_attribute(:phone, phone) if phone
    set_attribute(:tg, tg) if tg
    set_attribute(:email, email) if email
  end
  def set_git(git:nil)
    set_attribute(:git,git) if git
  end
  def change_fio(first_name: nil , last_name: nil,surname:nil)
    set_attribute(:first_name, first_name) if first_name
    set_attribute(:last_name, last_name) if last_name
    set_attribute(:surname, surname) if surname
  end

  def get_info
    fio = "#{@surname} #{initials}"
    git_info = git.nil? ? "Github is not set" : "#{@git}" 
    contact_info = get_contact

    "#{fio}\t#{git_info}\t#{contact_info}"
  end

  def initials
    "#{@first_name[0]}.#{@last_name[0]}."
  end

  def get_contact
    return "Phone: #{@phone}" if @phone 
    return "Email: #{@email}" if @email 
    return "Telegram: #{@tg}" if @tg 
    ""
  end

 
end

