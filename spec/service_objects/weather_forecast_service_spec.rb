
require 'rails_helper'

module WeatherForecastService
  RSpec.describe Forecast do
    subject { Forecast.new }
    let(:api_forecast) {
      {
        "days": [
          "temp": 70,
          "tempmax": 80,
          "tempmin": 60
        ]
      }
    }
    let(:forecast) {
      {
        :zipcode => "11230",
        "todays_temp" => 70,
        "high_temp" => 80,
        "low_temp" => 60,
        "five_day" => [{"temp"=>70, "tempmax"=>80, "tempmin"=>60}] # placeholder, not used yet
      }
    }

    describe "#call" do
      before do
      end
      context "location is nil" do
        let(:zipcode) { nil }
        it "should return an empty hash {}" do
          call_response = subject.call(location: zipcode)
          expect(call_response).to eq({})
        end
      end
      context "the zipcode does not exist in the DB" do
        let(:zipcode) { "11230" }
        it "should return a new api forecast" do
          allow(subject).to receive(
            :get_forecast
          ).with(location: zipcode). and_return(api_forecast)
          call_response = subject.call(location: zipcode)
          expect(call_response).to eq(forecast)
        end
      end
      context "the zipcode already exists in the DB" do
        context "its been less then 30 minutes" do
          it "should  not call the api" do
          end
        end
        context "its been more then 30 minutes" do
          it "should call the api" do
          end
        end
      end
    end
  end
end
