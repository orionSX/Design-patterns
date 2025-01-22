class StudentsList 
    def initialize(adapter)
        self.adapter = adapter
    end

    def get_student(id)
        self.adapter.get_student(id)
    end
    
    def get_k_n_student_short_list(k, n, data_list = nil, filters=nil)
        self.adapter.get_k_n_student_short_list(k, n, data_list,filters)
    end
    
    def add_student(student)
        self.adapter.add_student(student)
    end
    
    def update_student(id, new_student)
        self.adapter.update_student(id, new_student)
    end
    
    def delete_student(id)
        self.adapter.delete_student(id)
    end
    
    def student_count
        self.adapter.student_count
    end

    private
    attr_accessor :adapter
end
