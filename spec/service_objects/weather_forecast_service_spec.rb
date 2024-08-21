
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
    end
  end
end
