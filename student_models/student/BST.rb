class BinaryStudentTree
    include Enumerable
  
    attr_accessor :root
  
    def initialize(student=nil)
      @root = Node.new(student) if student
    end
  
    class Node
      attr_accessor :student, :left, :right
      def initialize(student)
        @student = student
        @left = nil
        @right = nil
      end
    end
  
    def add_student(student)
      @root = add_to_tree(@root, student)
    end
  
    def add_to_tree(node, student)
      return Node.new(student) if node.nil?
  
      if Date.parse(student.date_of_birth) <= Date.parse(node.student.date_of_birth)
        node.left = add_to_tree(node.left, student)
      else
        node.right = add_to_tree(node.right, student)
      end
      node
    end
  
    def DFS(node = @root, &block)
      return if node.nil?
  
      block.call(node.student)
      DFS(node.left, &block)
      DFS(node.right, &block)
    end
  
  
    def BFS
      queue = []
      queue.push(@root)
  
      while !queue.empty?
        node = queue.shift
        next if node.nil?
  
        yield node.student
  
        queue.push(node.left)
        queue.push(node.right)
      end
    end
    def each(type: :DFS,&block)
        self.send(type,&block)
      end
  
  
  end