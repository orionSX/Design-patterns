class DeepCopy
  def self.copy(obj)
    begin
      Marshal.load(Marshal.dump(obj))
    rescue TypeError
      deep_clone_fallback(obj)
    end
  end

  private

  def self.deep_clone_fallback(obj)
    case obj
    when Array
      obj.map { |element| copy(element) }
    when Hash
      obj.transform_values { |value| copy(value) }
    else
      clone_object(obj)
    end
  end

  def self.clone_object(obj)
    obj.dup
  rescue TypeError
    obj
  end
end
