class BST
    include Enumerable
  
    attr_accessor :root
  
    def initialize(data=nil)
      @root = Node.new(data) if data
    end
  
    class Node
      attr_accessor :data, :left, :right
      def initialize(data)
        @data=data
        @left = nil
        @right = nil
      end
    end
  
    def add_data(data)
      @root = add_to_tree(@root, data)
    end
  
    def add_to_tree(node, data)
      return Node.new(data) if node.nil?
  
    if data<= node.data
        node.left = add_to_tree(node.left, data)
      else
        node.right = add_to_tree(node.right, data)
      end
      node
    end
  
    def DFS(node = @root, &block)
      return if node.nil?
  
      block.call(node.data)
      DFS(node.left, &block)
      DFS(node.right, &block)
    end
  
  
    def BFS
      queue = []
      queue.push(@root)
  
      while !queue.empty?
        node = queue.shift
        next if node.nil?
  
        yield node.data
  
        queue.push(node.left)
        queue.push(node.right)
      end
    end
    def each(type: :DFS,&block)
        self.send(type,&block)
      end
  
  
  end
