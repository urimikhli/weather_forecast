
module VisualCrossingApi
  class GetForecast
    def call(location:)
      return {} if location.nil?

      api_key = ::VisualCrossingApi.api_key
      elements = "elements=datetime%2CdatetimeEpoch%2Caddress%2Ctempmax%2Ctempmin%2Ctemp"

      # future upgrade: these parameters could be set by the user rather then hardcoded
      current_day = Date.today
      todays_date = current_day.strftime("%Y-%m-%d")
      end_date = (current_day+5).strftime("%Y-%m-%d")
      unitGroup = "us" # degree type (F,C) [us,metric]

      request = "unitGroup=#{unitGroup}&#{elements}&include=days&key=#{api_key}&contentType=json"
      url = "#{location}/#{todays_date}/#{end_date}/?#{request}"

      response = VisualCrossingApi::HTTP.new.get(url)
      JSON.parse(response.body)
    end
  end
end
