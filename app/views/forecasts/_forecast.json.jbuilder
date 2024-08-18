json.extract! forecast, :id, :zipcode, :todays_temp, :high_temp, :low_temp, :created_at, :updated_at
json.url forecast_url(forecast, format: :json)
