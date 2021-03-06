$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "dmr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "dmr"
  spec.version     = 3.0
  spec.authors     = ["Richard Legacy"]
  spec.email       = ["richard.legacy@varland.com"]
  spec.homepage    = ""
  spec.summary     = "Summary of Dmr."
  spec.description = "Description of Dmr."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib, public}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.2.3"
  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'bootstrap'
  spec.add_dependency 'font-awesome-rails'
  spec.add_dependency 'rack-cors'

  spec.add_development_dependency "sqlite3"
end
