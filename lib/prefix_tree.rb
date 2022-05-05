# create prefix tree

require_relative 'node'
require 'csv'

WORD_EXIST = 'This word is already exist in prefix tree'
ADD_NEW_WORD = 'Add new word in prefix tree'
NO_WORD = 'This word is not in tree'

class PrefixTree
  attr_reader :dictionary

  def initialize
    @root = Node.new
    @number_of_input_strings = 0
    @dictionary = {}
    @dictionary_by_strings = {}
  end

  def add(input_value)
    input_value = convert_to_string(input_value)
    add_word(input_value.downcase)
  end

  def delete(input_value)
    return NO_WORD unless find(input_value)

    decrease_size(input_value)
    delete_string_index(input_value)
    delete_nodes(input_value)
  end

  def include?(input_value)
    find_prefix_node(input_value) ? true : false
  end

  def find(input_value)
    node = find_prefix_node(input_value)
    return false unless node

    node.is_end_point
  end

  def list(input_value)
    node = @root
    input_value.each_char do |char|
      node = find_node(node, char)
      return false unless node
    end
    write_appropriate_strings(node, input_value)
  end

  private

  def write_appropriate_strings(node, input_value)
    if input_value == ''
      puts @dictionary.values
    else
      puts_answer(node.strings_indexs)
    end
  end

  def puts_answer(indexs)
    indexs.each { |index| puts @dictionary[index] }
  end

  def add_word(input_value)
    return WORD_EXIST if find(input_value)

    dictionary_filler(input_value)
    fill_tree(input_value)
    ADD_NEW_WORD
  end

  def dictionary_filler(input_value)
    add_in_dictionary(input_value)
  end

  def add_in_dictionary(input_value)
    @number_of_input_strings += 1
    @dictionary_by_strings[input_value] = @number_of_input_strings
    @dictionary[@number_of_input_strings] = input_value
  end

  def fill_tree(input_value)
    node = @root
    input_value.each_char  { |char| node = back_new_node(node, char) } 
    node.become_end_point
  end

  def back_new_node(node, char)
    new_node = create_or_find_node(node, char)
    new_node.add_strings_indexs(@number_of_input_strings)
    new_node.increment_size
    new_node
  end

  def convert_to_string(input_value)
    input_value.to_s
  end

  def find_prefix_node(input_value)
    node = @root
    input_value.each_char do |char|
      node = find_node(node, char)
      return false unless node
    end
    node
  end

  def create_or_find_node(node, char)
    if node.include?(char)
      node.find(char)
    else
      node.create_child(char)
    end
  end

  def find_node(node, char)
    node.include?(char) ? node.find(char) : false
  end

  def delete_string_index(input_value)
    index = @dictionary_by_strings[input_value]
    @dictionary.delete(index)
    @dictionary_by_strings.delete(input_value)
  end

  def decrease_size(input_value)
    node = @root
    input_value.each_char do |char|
      node = node.find(char)
      change_size(node, input_value)
    end
    node.not_end_point
  end

  def change_size(node, input_value)
    node.decrement_size
    node.delete_element(@dictionary_by_strings[input_value])
  end

  def delete_nodes(input_value)
    node = @root
    input_value.each_char do |char|
      break unless node

      delete_nodes_in_node_class(node)
      node = node.find(char)
    end
  end

  def delete_nodes_in_node_class(node)
    node.delete_strings_indexs
    node.delete_node
  end
end


