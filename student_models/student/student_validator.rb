module StudentValidator
  NAME_REGEX= /\A[a-zA-Zа-яА-ЯёЁ'-]{1,50}\z/
  PHONE_REGEX=  /\A\+?\d{10,15}\z/
  EMAIL_REGEX= /\A[\w\-.]+@[a-zA-Z\d\-.]+\.[a-zA-Z]{2,}\z/
  GIT_REGEX=/\A(https:\/\/)?(www\.)?github.com\/[a-zA-Z0-9_-]+\z/
  TG_REGEX=/\A@[a-zA-Z0-9_]{5,32}\z/
  DATE_REGEX = /\A(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.(19|20|21|22|23|24|25|26|27|28|29|30|31)\d{2}\z/
  ANY_REGEX=//
  def valid?(value, reg)
    raise('Reg should be a regex') unless reg.is_a?(Regexp)
    !!(value.to_s =~ reg)
  end
end
