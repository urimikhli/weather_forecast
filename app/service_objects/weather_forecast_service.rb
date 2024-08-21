module WeatherForecastService
  class Forecast
    def call(location:)
      return {} if location.nil?

      current_forecast = ::Forecast.find_by(zipcode: location) || ::Forecast.new

      # only call api if forcast is older then 30 minutes
      # or there isnt a forecast for that location
      if current_forecast.updated_at.nil? || current_forecast.updated_at < 30.minutes.ago
        forecast = current_forecast.attributes
        response = VisualCrossingApi.get_forecast(location:)
        forecast = map_values(response).merge(zipcode: location)
      end
      forecast
    end
    private

    def map_values(forcast:)
      today = forcast['days'][0]
      {
        "todays_temp" => today['temp'],
        "high_temp" => today['tempmax'],
        "low_temp" => today['tempmin'],
        "five_day" => forcast['days'][0..5] # placeholder, not used yet
      }
    end
  end
end
