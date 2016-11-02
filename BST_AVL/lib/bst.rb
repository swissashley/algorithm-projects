class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if !@root
      @root = BSTNode.new(value)
      return
    end

    BinarySearchTree.insert!(@root, value)
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    @root = BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) unless node
    if value <= node.value
      node.left = self.insert!(node.left, value)
    else
      node.right = self.insert!(node.right, value)
    end
    node
  end

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value
    if value < node.value
      return self.find!(node.left, value)
    end
    return self.find!(node.right, value)
  end

  def self.preorder!(node)
    return [] unless node
    arr = [node.value]
    arr += self.preorder!(node.left) if node.left
    arr += self.preorder!(node.right) if node.right
    arr
  end

  def self.inorder!(node)
    return [] unless node
    arr = []
    arr += self.preorder!(node.left) if node.left
    arr << node.value
    arr += self.preorder!(node.right) if node.right
    arr
  end

  def self.postorder!(node)
    return [] unless node
    arr = []
    arr += self.postorder!(node.left) if node.left
    arr += self.postorder!(node.right) if node.right
    arr << node.value
    arr
  end

  def self.height!(node)
    return -1 unless node
    1 + [self.height!(node.left), self.height!(node.right)].max
  end

  def self.max(node)
    return nil unless node
    return node unless node.right
    self.max(node.right)
  end

  def self.min(node)
    return nil unless node
    return node unless node.left
    self.min(node.left)
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left
    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil unless node
    if value < node.value
      node.left = self.delete!(node.left, value)
    elsif value > node.value
      node.right = self.delete!(node.right, value)
    else
      return node.left unless node.right
      return node.right unless node.left
      t = node
      node = t.right.min
      node.right = BinarySearchTree.delete_min!(t.right)
      node.left = t.left
    end
    node
  end
end
