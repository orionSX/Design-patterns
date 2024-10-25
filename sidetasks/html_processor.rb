class HTMLTree
    include Enumerable
  
    attr_reader :root
  
    def initialize(input)
        if input.is_a?(String)
          @root = parse_html(input)
        elsif input.is_a?(Tag)
          @root = input
        else
          raise ArgumentError, 'Tag or str'
        end
      end
    
    def root_DFS(&block)
        tag_DFS(@root, &block)
    end  
    
    def tag_DFS(tag, &block)
      yield tag
      tag.children.each do |child|
        tag_DFS(child, &block)
      end
    end 

    def root_BFS
      queue = [@root]
      until queue.empty?
        tag = queue.shift
        yield tag
        queue.concat(tag.children)
      end
    end
    def parse_html(html_string)
    elements = parse_elements(html_string.strip)
    
        if elements.size == 1
            elements.first
        else
            root = Tag.new(name:'')
            elements.each { |element| root.add_child(element) }
            root
        end
    end
    
 
    def parse_elements(html_string)
        tags = []
      
        while !html_string.empty?
            if html_string =~ /\A<(\w+)(.*?)>(.*?)<\/\1>/m
                full_tag = $&
                tag_name = $1
                attributes_string = $2
                content_string = $3.strip
                
                attributes = parse_attributes(attributes_string)
                tag = Tag.new(name:tag_name, attributes:attributes)

                if content_string =~ /\A<(\w+)(.*?)>(.*?)<\/\1>/m   
                             
                    tag.add_child(parse_elements(content_string))
                else   
                                 
                    tag = Tag.new(name:tag_name, attributes:attributes, content:content_string)
                end

                tags << tag
                html_string.sub!(full_tag, '').strip
            
            else
                break
            end
        end
        tags
    end

    
    def parse_attributes(attributes_string)
        attributes = {}
        attributes_string.scan(/(\w+)=["'](.*?)["']/).each do |key, value|
            attributes[key] = value
        end
        attributes
    end
    def to_html
        @root.to_html
    end
    
  end
  

class Tag
    attr_reader :name, :attributes, :content, :children

    def initialize(name:"", attributes:{}, content:"")
        @name = name             
        @attributes = attributes  
        @content = content        
        @children = [] 

    end
    
  
    def add_child(tag)
        if tag.is_a?(Tag)
        @children << tag
        elsif tag.is_a?(Array)
            tag.each {|x| @children<<x}
        end
    end

    def content_length
        @content.length
      end
    
    def has_children?
    !@children.empty?
    end

    def children_count
    @children.size
    end

    def to_html(indent_level = 0)
        indent = '  ' * indent_level 
        attrs = @attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(" ")
        
       
        opening_tag = "#{indent}<#{@name}#{' ' unless attrs.empty?}#{attrs}>"
        if @children.any?
         
          inner_html = @children.map { |child| child.to_html(indent_level + 1) }.join("\n")
          closing_tag = "#{indent}</#{@name}>"
          "#{opening_tag}\n#{inner_html}\n#{closing_tag}"
        elsif @content
         
          closing_tag = "</#{@name}>"
          "#{opening_tag}#{@content}#{closing_tag}"
        else
         
          "#{opening_tag}</#{@name}>"
        end
      end


    
end


html = Tag.new(name:'html')
body = Tag.new(name:'body')
div = Tag.new(name:'div',attributes:{class: 'container'}, content:'zxcv')
p = Tag.new(name:'p', content:'xcvvvvz')
span = Tag.new(name:'span', content: 'zxcvzxcvzxct')


html.add_child(body)
body.add_child(div)
body.add_child(p)
div.add_child(span)

html_string = '<div class="container"><p>Hello</p><span>World</span></div><div class="container"><p>Hello</p><span>World</span></div>'

tree = HTMLTree.new(html_string)
puts tree.to_html
