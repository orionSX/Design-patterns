class MyArrayProcessor
    attr_reader :array

    def initialize(array:nil)
      @array = array
    end    
    
      
    
      
    def each_slice(slice_size)
        raise ArgumentError, "#{slice_size} is not positive!" if slice_size < 1  
        result = []
        i = 0
        while i < self.array.size
            slice = self.array[i, slice_size]
        
            result << slice.to_a
            yield slice if block_given?
            i += slice_size
        end
        result
    end
    
     
    def max_by       
        return self.array.max unless block_given?
        max_element = self.array.first
        max_value = yield(max_element)
        
        self.array.each do |element|
            current_value = yield(element)
            if current_value > max_value
                max_element = element
                max_value = current_value
            end
        end
        max_element
    end
    
    def sort_by 
      while true 
        swapped = false
      (0...@array.size-1).each do |i|
          if block_given?
            if yield(@array[i]) > yield(@array[i + 1])
              @array[i], @array[i + 1] = @array[i + 1], @array[i]
              swapped = true
            end
          else
            if @array[i] > @array[i + 1]
              @array[i], @array[i + 1] = @array[i + 1], @array[i]
              swapped = true
            end
          end
        end
        break unless swapped
      end
      @array
    end
  
    def cycle(n=nil)
        raise ArgumentError, "block should be given" if !block_given?
        raise ArgumentError, "#{n} should be gt 1!" if n < 1  && !n.nil?
        if n.nil?
            while true
                self.array.each {|el| yield(el)}
            end 
        end
        count = 0
        while count < n
            self.array.each {|el| yield(el)}
            count += 1
        end
    end

 
    def inject(initial=self.array[0])
        accumulator = initial
        self.array.each do |element|
            accumulator = yield(accumulator, element)
        end
        accumulator
    end

    def reject
        return [] unless block_given?

        result = []
        self.array.each do |element|
            result << element unless yield(element)
        end
    result
    end


end 

