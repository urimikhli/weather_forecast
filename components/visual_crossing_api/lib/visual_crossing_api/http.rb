require 'visual_crossing_api/error'
require 'faraday'

module VisualCrossingApi
  class HTTP
    TIMEOUT_SECONDS = 100

    %w[get post put].each do |method|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method}(
          absolute_path,
          request_body = nil,
          bearer: nil,
          headers: {}
        )
          headers['Authorization'] = 'Bearer ' + bearer if bearer
          run_request(:#{method}, absolute_path, headers, request_body)
        end
      RUBY
    end

    protected

    def base_url
      VisualCrossingApi.base_url
    end

    # :reek:TooManyStatements
    def run_request(verb, absolute_path, headers, request_body)
      url = base_url + absolute_path

      headers = default_headers.merge(headers)
      response = connection.send(verb, url) do |req|
        headers.each do |name, value|
          req.headers[name] = value
        end
        req.options.timeout = TIMEOUT_SECONDS
        req.body = request_body if request_body
      end
      response
    rescue Faraday::TimeoutError
      raise VisualCrossingApi::TimeoutError
    rescue Faraday::ClientError => e
      raise VisualCrossingApi::ApiError, e
    end

    def connection
      Faraday.new do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::RaiseError
        builder.adapter Faraday.default_adapter
      end
    end

    def default_headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end
  end
end