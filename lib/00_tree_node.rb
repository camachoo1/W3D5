require 'byebug'
class PolyTreeNode
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def value
        @value
    end
    def parent
        @parent
    end
    def children
        @children
    end

    def parent=(parent)
        if self.parent 
            self.parent.children.delete(self)
        end
        @parent = parent
        unless parent.nil? or parent.children.include?(self)
            parent.children << self
        end
        self
    end

    def add_child(child)
        child.parent= self
    end

    def remove_child(child)
        unless self.children.include?(child)
            raise "error"
        else
            child.parent = nil
        end
        self
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child| 
            res = child.dfs(target_value)
            return res unless res.nil?
        end
        nil
    end

    def bfs(target_value)
       #return self if self.value == target_value
        queue = [self]
        until queue.empty?
            node = queue.shift
            #p node.value
            return node if node.value == target_value
            
            node.children.each {|child| queue.push(child) unless child.nil?}
        end
        nil
    end

    def print_node
        queue = [self]
        list = []
        until queue.empty?
            node = queue.shift
            list << node.value
            node.children.each {|node| queue.push(node) unless node.nil?}
        end
        list.each {|v| print "#{v}, "}
    end
end
# root_node = PolyTreeNode.new(1)
# node1 = PolyTreeNode.new(2)
# node2 = PolyTreeNode.new(3)
# node3 = PolyTreeNode.new(4)
# node4= PolyTreeNode.new(5)
# node5= PolyTreeNode.new(6)
# node6=PolyTreeNode.new(7)
# node2.parent = root_node
# node3.parent = root_node
# node4.parent = node2
# node5.parent = node2
# node6.parent = node3
# node7.parent = node3 
# p root_node.dfs(4)