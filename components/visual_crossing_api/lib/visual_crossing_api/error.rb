module VisualCrossingApi
  class Error < StandardError
  end

  class ApiError < StandardError
    attr_reader :exception

    def initialize(exception)
      @exception = exception

      raise ContextError, api_error_message
    end

    def api_error_message
      exception_response = exception.response
      {
        body: exception_response&.fetch(:body, nil),
        message: exception.message,
        status: exception_response&.fetch(:status, nil),
        exception_name: exception.class.to_s
      }.to_json
    end

    def self.get_parsed_error(error)
      error_message = JSON.parse(error.message)

      error_body =  if error_message["body"].empty?
                      error_message
      else
        JSON.parse(error_message["body"])
      end
      message = safely_get_message(error_body)

      {
        status: error_message["status"],
        message: message
      }
    end

    def self.safely_get_message(error_body)
      error_part = error_body["error"]

      if error_part.is_a? Hash
        error_body.dig("error", "message")
      else
        error_body["error_description"] || error_part || "Unknown error"
      end
    end
  end

  class ContextError < StandardError
  end

  class TimeoutError < Error
  end

  class MissingCountorWeight < Error
  end
end
