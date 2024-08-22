# frozen_string_literal: true

require 'vcr'
require 'bundler/setup'
require 'visual_crossing_api'

SimpleCov.start

lib = File.expand_path('lib', File.join(__dir__, '..'))
$LOAD_PATH << lib

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.allow_http_connections_when_no_cassette = true
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.ignore_localhost = true
  config.ignore_hosts 'chromedriver.storage.googleapis.com'
end

RSpec.configure do |config|

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    base_url = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/timeline/'
    api_key = 'HRAT2H5X62YW96SGH4WFUVD9R'

    VisualCrossingApi.configure(
      base_url: base_url,
      api_key: api_key
    )
  end
end
