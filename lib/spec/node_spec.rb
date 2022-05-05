# create tests for node class

require '../node'
require 'rspec/autorun'

describe Node do
  subject(:root) { described_class.new }

  before(:each) do
    @node = Node.new('t')
    @first_child_node = @node.create_child('m')
    @second_child_node = @node.create_child('d')
    @not_child_node = Node.new('d')
  end

  describe '#initialize' do
    context 'check root attributs' do
      it 'root value is root' do
        expect(root.value).to eq('root')
      end

      it 'root children is empty' do
        expect(root.children.empty?).to be_truthy
      end

      it 'nodes include root' do
        expect(Node.nodes.include?(root)).to be_truthy
      end

      it 'root is not end point' do
        expect(root.is_end_point).to be_falsey
      end

      it 'root number_size is 0' do
        expect(root.number_size).to be_zero
      end
    end

    let(:node) { described_class.new('t') }

    context 'create node and check attributs' do
      it 'mode value is root' do
        expect(node.value).to eq('t')
      end

      it 'node children is empty' do
        expect(node.children.empty?).to be_truthy
      end

      it 'nodes include node' do
        expect(Node.nodes.include?(node)).to be_truthy
      end

      it 'node is not end point' do
        expect(node.is_end_point).to be_falsey
      end

      it 'node number_size is 0' do
        expect(node.number_size).to be_zero
      end
    end
  end

  describe '#create_child' do
    context 'create child for node' do
      it 'node children is not empty' do
        expect(@node.children.empty?).to be_falsey
      end

      it 'check first_child_node' do
        expect(@node.children.include?(@first_child_node)).to be_truthy
      end

      it 'check second_child_node' do
        expect(@node.children.include?(@second_child_node)).to be_truthy
      end

      it 'check that not_child_node' do
        expect(@node.children.include?(@not_child_node)).to be_falsey
      end

      it 'node children' do
        expect(@node.children).to eq([@first_child_node, @second_child_node])
      end
    end
  end

  describe '#nodes' do
    context 'see every node' do
      it 'node is part of nodes' do
        expect(Node.nodes.include?(@node)).to be_truthy
      end

      it 'first_child_node is part of node' do
        expect(Node.nodes.include?(@first_child_node)).to be_truthy
      end

      it 'second_child_node is part of nodes' do
        expect(Node.nodes.include?(@second_child_node)).to be_truthy
      end

      let(:other_child_node) { described_class.new('d') }

      it 'other_child_node is part of nodes' do
        expect(Node.nodes.include?(other_child_node)).to be_truthy
      end
    end
  end

  describe '#to_s' do
    context 'to_s is puts values' do
      it 'puts nodes children' do
        expect(@first_child_node.to_s).to eq('m')
      end

      it 'puts nodes children' do
        expect(@second_child_node.to_s).to eq('d')
      end

      it 'puts nodes children' do
        expect(@node.to_s).to eq('t')
      end
    end
  end

  describe '#include?' do
    context 'check include? method' do
      it 'node children include first_child_node' do
        expect(@node.include?(@first_child_node.to_s)).to be_truthy
      end

      it 'node children include second_child_node' do
        expect(@node.include?(@second_child_node.to_s)).to be_truthy
      end
    end
  end

  describe '#find' do
    context 'check find function' do
      it 'return first_child_node' do
        expect(@node.find(@first_child_node.to_s)).to equal(@first_child_node)
      end

      it 'return second_child_node' do
        expect(@node.find(@second_child_node.to_s)).to equal(@second_child_node)
      end
    end
  end

  describe '#delete_node' do
    context 'check delete_node method' do
      it 'delete_node from node' do
        @second_child_node.increment_size
        @node.delete_node
        expect(@node.children).to eq([@second_child_node])
      end

      it 'delete_node from node' do
        @node.delete_node
        expect(@node.children).to be_empty
      end
    end
  end

  describe '#become_end_point' do
    context 'check become_end_point method' do
     it 'when node is not is_end_point and and become end point' do
        @node.become_end_point
        expect(@node.is_end_point).to be_truthy
      end

      it 'when node is not end point' do
        expect(@node.is_end_point).to be_falsey
      end
    end
  end

  describe '#not_end_point' do
    context 'check not_end_point method' do
      it 'when node is_end_point and and become not end point' do
        @node.not_end_point
        expect(@node.is_end_point).to be_falsey
      end
    end
  end

  describe '#increment_size' do
    context 'check increment_size method' do
      it 'increment_size' do
        @node.increment_size
        expect(@node.number_size).to eq(1)
      end

      it 'increment_size twice' do
        2.times { @node.increment_size }
        expect(@node.number_size).to eq(2)
      end
    end
  end

  describe '#decrement_size' do
    context 'check decrement_size method' do
      it 'increment_size and decrement_size' do
        @node.increment_size
        @node.decrement_size
        expect(@node.number_size).to eq(0)
      end

      it 'increment_size twice and decrement_size ones' do
        3.times { @node.increment_size }
        @node.decrement_size
        expect(@node.number_size).to eq(2)
      end
    end
  end

  describe '#add_strings_indexs' do
    context 'check add_strings_indexs method' do
      it 'add_strings_indexs 2 times' do
        numbers = [10, 12]
        numbers.each { |number| @first_child_node.add_strings_indexs(number) }
        expect(@first_child_node.strings_indexs).to eq(numbers)
      end

      it 'add_strings_indexs 4 times' do
        numbers = [10, 12, 14, 11]
        numbers.each { |number| @node.add_strings_indexs(number) }
        expect(@node.strings_indexs).to eq(numbers)
      end
    end
  end

  describe '#delete_strings_indexs' do
    context 'check delete_strings_indexs method' do
      it 'delete strings indexs' do
        node_numbers = [10, 12, 14, 11]
        numbers = [10, 12]
        numbers.each { |number| @first_child_node.add_strings_indexs(number) }
        node_numbers.each { |number| @node.add_strings_indexs(number) }
        @node.delete_strings_indexs
        expect(@node.strings_indexs).to eq(node_numbers - numbers)
      end
    end
  end

  describe '#delete_elemnt' do
    context 'check delete_elemnt method' do
      it 'delete element which value is 5' do
        numbers = [5, 6, 3]
        numbers.each { |number| @node.add_strings_indexs(number) }
        @node.delete_element(6)
        expect(@node.strings_indexs).to eq([5, 3])
      end
    end
  end
end

