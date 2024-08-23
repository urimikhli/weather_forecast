require "visual_crossing_api/version"
require "visual_crossing_api/error"
require "visual_crossing_api/http"
require "visual_crossing_api/get_forecast"

module VisualCrossingApi
  class << self
    attr_reader :base_url, :api_key

    def configure(base_url:,api_key:)
      @base_url = base_url
      @api_key = api_key
    end
  end
end
