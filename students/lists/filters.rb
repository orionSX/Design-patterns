class Filter
    def apply(students)
      students
    end
end
  

  class NameFilter < Filter
    def initialize(first_name)
        @first_name=first_name      
      end
    
      def apply(students)
        students.select { |s| s.first_name == @first_name }
      end
  end
  class SurnameFilter < Filter
    def initialize(surname)
      @surname=surname      
    end
  
    def apply(students)
      students.select { |s| s.surname == @surname }
    end
  end
  class LastnameFilter < Filter
    def initialize(last_name)
        @last_name=last_name      
      end
    
      def apply(students)
        students.select { |s| s.last_name == @last_name }
      end
  end
  
  class FilterDecorator < Filter
    def initialize(*filters)
      
        @filters = filters
    end
    
    def apply(students)
      @filters.reduce(students) do |filtered_students, filter|
        begin
        filter.apply(filtered_students)
        rescue
          filtered_students
        end
      end
    end
     
  end 