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
  
    def DFS_rec(node = @root, &block)
      return if node.nil?
  
      block.call(node.student)
      DFS_rec(node.left, &block)
      DFS_rec(node.right, &block)
    end
  
    def DFS_stack
      stack = []
      stack.push(@root)
  
      while !stack.empty?
        node = stack.pop
        next if node.nil?
  
        yield node.student
  
        stack.push(node.right) 
        stack.push(node.left)
      end
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
  
  
  
  end