# create prefix tree tests

require '../prefix_tree'
require 'rspec/autorun'

describe PrefixTree do
  describe '#add' do
    let(:trie) { described_class.new }

    context 'check add string method' do
      it 'add string in tree' do
        %w(string str).each { |string| trie.add(string) }

        expect(trie.dictionary.values).to eq(%w[string str])
      end

      it 'add int by converting string in tree' do
        %w(1 str).each { |string| trie.add(string) }

        expect(trie.dictionary.values).to eq(%w[1 str])
      end

      it "don't add same string twice" do
        %w(str str).each { |string| trie.add(string) }

        expect(trie.dictionary.values).to eq(['str'])
      end
    end
  end

  before (:each) do
    @tree = described_class.new
    @tree.add('string')
    @tree.add('str')
  end

  describe '#include?' do
    context 'tree include strings' do
      it 'tree include str' do
        expect(@tree.include?('str')).to be_truthy
      end

      it 'tree include string' do
        expect(@tree.include?('string')).to be_truthy
      end

      it "tree don't include strin" do
        expect(@tree.include?('strin')).to be_truthy
      end
    end
  end

  describe '#find' do
    context 'check find method' do
      it 'find string' do
        expect(@tree.find('str')).to be_truthy
      end

      it 'tree include string' do
        expect(@tree.find('string')).to be_truthy
      end

      it "tree don't include strin" do
        expect(@tree.find('strin')).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'delete string from tree' do
      it 'delete string' do
        @tree.delete('str')

        expect(@tree.find('str')).to be_falsey
      end

      it 'delete string but other string stay' do
        @tree.delete('str')

        expect(@tree.find('string')).to be_truthy
      end

      it "delete string which don't exist" do
        expect(@tree.delete('mmd')).to eq(NO_WORD)
      end
    end
  end

  describe '#list' do
    before (:example) do
      @tree = described_class.new()
      @tree.add('string')
      @tree.add('strw')
      @tree.add('str')
      @tree.add('stm')
    end

    context 'check list method' do
      it 'add some string and find list' do
        answer = "string\nstrw\nstr\n"

        expect { @tree.list('str') }.to output(answer).to_stdout
      end

      it 'add and delete some string and find list' do
        @tree.delete('string')
        answer = "strw\nstr\n"

        expect { @tree.list('str') }.to output(answer).to_stdout
      end

      it 'add and delete, add some string and find list' do
        @tree.delete('string')
        @tree.add('string')
        answer = "strw\nstr\nstring\n"

        expect { @tree.list('str') }.to output(answer).to_stdout
      end

      it 'puts every word when input noting' do
        @tree.delete('string')
        @tree.add('string')
        answer = "strw\nstr\nstm\nstring\n"

        expect { @tree.list('') }.to output(answer).to_stdout
      end

      it 'puts nothing when input value is not in tree' do
        @tree.delete('string')
        @tree.add('string')
        answer = ''

        expect { @tree.list('mm') }.to output(answer).to_stdout
      end
    end
  end
end


