
require 'rails_helper'

module WeatherForecastService
  RSpec.describe Forecast do
    subject { Forecast.new }
    let(:zipcode) { "11230" }
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
      context "the zipcode does not exist in the DB"
      context "the zipcode already exists in the DB" do
        context "its been less then 30 minutes"
        context "its been more then 30 minutes"
      end
    end
  end
end
