Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_simple_blog'
  s.version     = '3.0.2'
  s.summary     = 'Adds a basic blog with admin management tools'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Josh Nussbaum'
  s.email             = 'joshnuss@gmail.com'
  s.homepage          = 'http://spreecommerce.com'
  s.rubyforge_project = 'spree_simple_blog'

  s.files        = Dir['README.md', 'lib/**/*', 'app/**/*', 'config/*', 'config/locales/*', 'db/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = false

  s.add_dependency('spree_core',  '>= 0.30.1')
  s.add_dependency('acts-as-taggable-on',  '>= 2.0.0.rc1')
end

