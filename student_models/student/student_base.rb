require_relative "student_validator.rb"
require 'date'
class StudentBase
include StudentValidator

  attr_reader :id,:git

  def initialize(id:nil,git:nil)
    @id=id.to_i
    set_attribute(:git,git) if git
  end
  
  def validate?
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
  def contact
    return "Phone: #{@phone}" if @phone 
    return "Email: #{@email}" if @email 
    return "Telegram: #{@tg}" if @tg   
    return @contact if @contact  
    ""
  end
  def get_info
    if @FIO
      fio=self.FIO
    else
      fio="#{@surname} #{@first_name[0]}.#{@last_name[0]}."
    end
    git_info = self.git.to_s
    contact_info = self.contact

    "#{fio}\t#{git_info}\t#{contact_info}"
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
      FIO:ANY_REGEX,
      date_of_birth:DATE_REGEX
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
