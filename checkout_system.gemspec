require File.expand_path('../lib/checkout_system/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.name = 'checkout_system'
  gem.summary = 'Simple checkout system'
  gem.description = 'Checkout system implementation for TextMaster'
  gem.version = CheckoutSystem::VERSION.dup
  gem.authors = ['David Jeusette']
  gem.email = ['jeusette.david@gmail.com']
  gem.homepage = 'https://github.com/djeusette/checkout_system'
  gem.require_paths = ['lib']
  gem.license = 'MIT'

  # gem.files = `git ls-files`.split("\n")
  # gem.test_files = `git ls-files -- spec/*`.split("\n")

  gem.files = Dir["lib/**/*"] + ["Rakefile", "README.md"]
end
