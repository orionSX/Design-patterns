class MyArrayProcessor
    attr_reader :array

    def initialize(array:nil)
        @array = array.freeze
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
    return self.array.sort unless block_given?

    self.array.sort {|a,b|  yield(a) <=> yield(b)}      
  
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

class MyArrayProcessorAutoTest
    def MyArrayProcessorAutoTest.run_tests
        obj=MyArrayProcessorAutoTest.new()
        results=[]
        obj.public_methods(false).each do |method_name|
        puts "Вызов #{method_name}"
        puts obj.send(method_name)
        results <<obj.public_methods(method_name)
        
        end
        if results.all?
            puts "passed all test"
        else
            puts "didnt pass"
        end
        
    end 
    def initialize
        @array_processor = MyArrayProcessor.new(array:[1, 2, 3, 4, 5])
      end
    
      def test_elements
       
        [1, 2, 3, 4, 5] == @array_processor.array
      end
    
      def test_each_slice
        result = []
        @array_processor.each_slice(2) { |slice| result << slice }
        [[1, 2], [3, 4], [5]] == result
      end
    
      def test_max_by
        max_by = @array_processor.max_by { |x| -x }
        1 == max_by
      end
    
      def test_sort_by
        sorted = @array_processor.sort_by { |x| -x }
        [5, 4, 3, 2, 1] == sorted
      end
    
      def test_cycle
        result = []
        @array_processor.cycle(2) { |x| result << x }
        [1, 2, 3, 4, 5, 1, 2, 3, 4, 5] ==  result
      end
    
      def test_inject
        sum = @array_processor.inject(0) { |acc, x| acc + x }
        15 == sum
      end
    
      def test_reject
        rejected = @array_processor.reject { |x| x.even? }
        [1, 3, 5]== rejected
      end


end

MyArrayProcessorAutoTest.run_tests