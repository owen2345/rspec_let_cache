require_relative "lib/rspec_let_cache/version"

Gem::Specification.new do |spec|
  spec.name        = "rspec_let_cache"
  spec.version     = RspecLetCache::VERSION
  spec.authors     = ['Owen Peredo']
  spec.email       = ['owenperedo@gmail.com']
  spec.homepage    = "http://github.com/owen2345/rspec_let_cache"
  spec.summary     = "Permit to cache let variables across tests"
  spec.description = "Permit to cache let variables across tests"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'rspec'
end
