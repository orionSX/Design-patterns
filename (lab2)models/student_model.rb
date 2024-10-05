

module StudentValidator
  NAME_REGEX= /\A[a-zA-Zа-яА-ЯёЁ'-]{1,50}\z/
  PHONE_REGEX=  /\A\+?\d{10,15}\z/
  EMAIL_REGEX= /\A[\w\-.]+@[a-zA-Z\d\-.]+\.[a-zA-Z]{2,}\z/
  GIT_REGEX=/\A(https:\/\/)?(www\.)?github.com\/[a-zA-Z0-9_-]+\z/
  TG_REGEX=/\A@[a-zA-Z0-9_]{5,32}\z/
  ANY_REGEX=//
  def valid?(value, reg)
    raise('Reg should be a regex') unless reg.is_a?(Regexp)
    !!(value.to_s =~ reg)
  end
end

class StudentBase
include StudentValidator

  attr_reader :id,:git

  def initialize(id:nil,git:nil)
    @id=id.to_i
    set_attribute(:git,git) if git
  end
  
  def validate
    s=instance_variables.map do |key|
      val = instance_variable_get(key)
      key_name = key.to_s.delete_prefix('@')
      if key_name=="contact"||key_name=='phone'||key_name=='email'||key_name=='tg' && !val.to_s.empty?
        
        val
      else
          nil
      end
    end.compact.join("")

    !@git.nil? &&( s.length!=0)
  end
  def to_s
    instance_variables.map do |key|
      val = instance_variable_get(key)
      key_name = key.to_s.delete_prefix('@')
      "#{key_name}: #{val}" unless val.nil? || val.to_s.empty?
    end.compact.join("\n")
  end
  private
  def set_attribute(attr_name, value)
    regex_map = {
      email: EMAIL_REGEX,
      tg: TG_REGEX,
      git: GIT_REGEX,
      phone: PHONE_REGEX,
      first_name: NAME_REGEX,
      surname: NAME_REGEX,
      last_name: NAME_REGEX,
      contact: ANY_REGEX,
      fio:ANY_REGEX,
    }

    regex = regex_map[attr_name]
    raise "Validation not defined for #{attr_name}" unless regex

    if valid?(value, regex)
      instance_variable_set("@#{attr_name}", value.to_s)
    else
      raise "Incorrect #{attr_name}: #{value}"
    end
  end
 
end


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
  private

  
  
 



 
 
end

class StudentShort < StudentBase
  attr_reader  :fio, :contact

  def initialize(student: nil, id: nil, student_str: nil)
    
    if student      
      super(id:student.id,git:student.git)
      short_setter(student.get_info)
    elsif id && student_info
      super(id:id)
      short_setter(student_str)
    end
  end

  def short_setter(info)
    info_arr=info.split("\t")
    set_attribute(:fio,info_arr[0])
    set_attribute(:git,info_arr[1])
    set_attribute(:contact,info_arr[2])
 
  end
end
