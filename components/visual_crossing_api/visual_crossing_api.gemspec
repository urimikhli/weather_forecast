require_relative "lib/visual_crossing_api/version"

Gem::Specification.new do |spec|
  spec.name        = "visual_crossing_api"
  spec.version     = VisualCrossingApi::VERSION
  spec.authors     = [ "Uri Mikhli" ]
  spec.email       = [ "urimikhli@gmail.com" ]
  spec.summary     = "VisualCrossingApi."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host' to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://donotpush.example.com'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency 'rspec'
  spec.add_dependency 'rake'
  spec.add_dependency 'faraday'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
