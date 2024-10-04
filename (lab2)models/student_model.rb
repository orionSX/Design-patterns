

class StudentValidator
  NAME_REGEX= /\A[a-zA-Zа-яА-ЯёЁ'-]{1,50}\z/
  PHONE_REGEX=  /\A\+?\d{10,15}\z/
  EMAIL_REGEX= /\A[\w\-.]+@[a-zA-Z\d\-.]+\.[a-zA-Z]{2,}\z/
  GIT_REGEX=/\A(https:\/\/)?(www\.)?github.com\/[a-zA-Z0-9_-]+\z/
  TG_REGEX=/\A@[a-zA-Z0-9_]{5,32}\z/

  def valid?(value, reg)
    raise('Reg should be a regex') unless reg.is_a?(Regexp)
    !!(value.to_s =~ reg)
  end
end

class Student < StudentValidator
  @@id = 0

  attr_reader :id, :email, :phone, :tg, :git

  def initialize(first_name:, surname:, last_name:,phone: nil, tg: nil, git: nil, email: nil)
    set_fio(first_name, surname, last_name)
    set_contacts(phone: phone, tg: tg, git: git, email: email)
    @id = @@id
    @@id += 1
  end

  def to_s
    instance_variables.map do |key|
      val = instance_variable_get(key)
      key_name = key.to_s.delete_prefix('@')
      "#{key_name}: #{val}" unless val.nil? || val.to_s.empty?
    end.compact.join("\n")
  end

  def validate
    (valid?(@git, GIT_REGEX) && !@git.nil?) &&
    (valid?(@email, EMAIL_REGEX) && !@email.nil? || valid?(@phone, PHONE_REGEX) && !@phone.nil? || valid?(@tg, TG_REGEX) && !@tg.nil?)
  end
 
  def set_contacts(phone: nil , tg: nil, git:nil, email:nil)
    set_attribute(:phone, phone) if phone
    set_attribute(:tg, tg) if tg
    set_attribute(:git, git) if git
    set_attribute(:email, email) if email
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
      last_name: NAME_REGEX
    }

    regex = regex_map[attr_name]
    raise "Validation not defined for #{attr_name}" unless regex

    if valid?(value, regex)
      instance_variable_set("@#{attr_name}", value.to_s)
    else
      raise "Incorrect #{attr_name}: #{value}"
    end
  end
  
 

  def set_fio(first_name, surname, last_name)
    set_attribute(:first_name, first_name)
    set_attribute(:surname, surname)
    set_attribute(:last_name, last_name)
  end

 
 
end
