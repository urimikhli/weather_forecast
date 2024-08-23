
require 'spec_helper'
require 'visual_crossing_api/get_forecast'

module VisualCrossingApi
  RSpec.describe GetForecast do
    describe '#call' do
      let(:location) { "11230" }
      let(:api_forecast) {
        {
          "queryCost"=>1,
          "latitude"=>40.622994,
          "longitude"=>-73.96427,
          "resolvedAddress"=>"11230, USA",
          "address"=>"11230",
          "timezone"=>"America/New_York",
          "tzoffset"=>-4.0,
          "days"=>
            [ { "datetime"=>"2024-08-23", "datetimeEpoch"=>1724385600, "tempmax"=>81.9, "tempmin"=>65.0, "temp"=>72.9 },
            { "datetime"=>"2024-08-24", "datetimeEpoch"=>1724472000, "tempmax"=>78.0, "tempmin"=>67.0, "temp"=>72.9 },
            { "datetime"=>"2024-08-25", "datetimeEpoch"=>1724558400, "tempmax"=>79.1, "tempmin"=>69.0, "temp"=>74.1 },
            { "datetime"=>"2024-08-26", "datetimeEpoch"=>1724644800, "tempmax"=>76.7, "tempmin"=>71.3, "temp"=>74.1 },
            { "datetime"=>"2024-08-27", "datetimeEpoch"=>1724731200, "tempmax"=>76.9, "tempmin"=>70.6, "temp"=>73.6 },
            { "datetime"=>"2024-08-28", "datetimeEpoch"=>1724817600, "tempmax"=>77.8, "tempmin"=>71.5, "temp"=>74.9 } ]
        }
      }
      context 'get the weather forecast for the zipcode' do
        it "should the forecast from the API" do
          response = nil
          VCR.use_cassette('get_forecast/success') do
              response = VisualCrossingApi::GetForecast.new.call(location:)
          end
          expect(response).to eq(api_forecast)
        end
      end
    end
  end
end
