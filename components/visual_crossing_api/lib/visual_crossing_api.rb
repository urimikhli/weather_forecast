require "visual_crossing_api/version"

module VisualCrossingApi
  class << self
    attr_reader :base_url, :api_key

    def configure(base_url:,api_key:)
      @base_url = base_url
      @api_key = api_key
    end
  end
end
