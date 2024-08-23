
require 'rails_helper'

module WeatherForecastService
  RSpec.describe Forecast do
    subject { Forecast.new }
    let(:zipcode) { "11230" }
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
        :zipcode => zipcode,
        "todays_temp" => 70,
        "high_temp" => 80,
        "low_temp" => 60,
        "five_day" => [{"temp"=>70, "tempmax"=>80, "tempmin"=>60}] # placeholder, not used yet
      }
    }

    describe "#call" do
      before do
        allow(subject).to receive(
            :get_forecast
          ).with(location: zipcode). and_return(api_forecast)
      end
      context "location is nil" do
        let(:zipcode) { nil }
        it "should return an empty hash {}" do
          call_response = subject.call(location: zipcode)
          expect(call_response).to eq({})
        end
      end
      context "the zipcode does not exist in the DB" do
        it "should return a new api forecast" do
          call_response = subject.call(location: zipcode)
          expect(call_response).to eq(forecast)
        end
      end
      context "the zipcode already exists in the DB" do
        let!(:existing_forecast) { create(:forecast, zipcode: zipcode) }
        context "when it has been less then 30 minutes" do
          it "should  not call the api, but return the existing object" do
            call_response = subject.call(location: existing_forecast.zipcode)
            expect(call_response["todays_temp"]).to eq(existing_forecast["todays_temp"])
          end
        end
        context "when it has been more then 30 minutes" do
          let!(:old_forecast) { 
            existing_forecast.update(updated_at: 1.hour.ago)
            existing_forecast.save
            existing_forecast
           }
          it "should call the api and return the latest forecast" do
            call_response = subject.call(location: old_forecast.zipcode)
            expect(call_response["todays_temp"]).to eq(forecast["todays_temp"])
          end
        end
      end
    end
  end
end
