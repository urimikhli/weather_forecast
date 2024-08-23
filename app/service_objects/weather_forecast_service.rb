require 'visual_crossing_api'
require 'visual_crossing_api/get_forecast'

module WeatherForecastService
  class Forecast
    def call(location:)
      return {} if location.nil?

      current_forecast = ::Forecast.find_by(zipcode: location) || ::Forecast.new
      forecast = current_forecast.attributes
      # only call api if forcast is older then 30 minutes
      # or there isnt a forecast for that location
      if current_forecast.updated_at.nil? || current_forecast.updated_at < 30.minutes.ago
        response = get_forecast(location:)
        forecast = map_values(forecast: response).merge(zipcode: location)
      end
      forecast
    end

    # entry point to external API
    def get_forecast(location:)
      VisualCrossingApi::GetForecast.new.call(location:)
    end

    private

    def map_values(forecast:)
      today = forecast.with_indifferent_access["days"][0]
      {
        "todays_temp" => today["temp"],
        "high_temp" => today["tempmax"],
        "low_temp" => today["tempmin"],
        "five_day" => forecast.with_indifferent_access["days"][0..5] # placeholder, not used yet
      }
    end
  end
end
