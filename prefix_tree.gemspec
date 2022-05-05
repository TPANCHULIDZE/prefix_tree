# gem for prefix tree
require File.expand_path('lib/prefix_tree/version', __dir__)

Gem::Specification.new do |tree|

  tree.name = 'prefix_tree_gem'
  tree.version = '1.0.0'
  tree.authors = ['tato']
  tree.email = 'tpanchulidze@unisens.ge'
  tree.summary = 'prefix tree'
  tree.description = 'prefix tree algorithm'
  tree.homepage = 'https://github.com/TPANCHULIDZE/prefix_tree.git'
  tree.license = 'MIT'
  tree.platform = Gem::Platform::RUBY
  tree.required_ruby_version = '>= 2.5.0'

  spec.files = Dir['README.md', 'LICENSE',
                 'CHANGELOG.md', 'lib/**/*.rb',
                 'lib/**/*.rake',
                 'prefix_tree_gem.gemspec', '.github/*.md',
                 'Gemfile', 'Rakefile']

  spec.extra_rdoc_files = ['README.md']

  spec.add_dependency 'ruby-lokalise-api', '~> 3.1'
  spec.add_dependency 'rubyzip', '~> 2.3'
  spec.add_development_dependency 'rubocop', '~> 0.60'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.37'
end

