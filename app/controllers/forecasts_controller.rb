class ForecastsController < ApplicationController
  before_action :get_forecast, only: %i[ create update destroy index ]

  attr_accessor :todays_temp, :high_temp, :low_temp
  # GET /forecasts or /forecasts.json
  def index
    zipcode = params['zipcode']

    @forecast = Forecast.find_by(zipcode: zipcode) || Forecast.new
  end

  # GET /forecasts/1 or /forecasts/1.json
  def show
  end

  # GET /forecasts/new
  def new
    @forecast = Forecast.new
  end

  # GET /forecasts/1/edit
  def edit
  end

  # POST /forecasts or /forecasts.json
  def create
    # @forecast = Forecast.new(forecast_params) if @forecast&.id.nil?

    respond_to do |format|
      if @forecast.save
        format.html { redirect_to forecasts_path(zipcode: @forecast.zipcode), notice: "Forecast was successfully created." }
        format.json { render :index, status: :created, location: @forecast }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forecasts/1 or /forecasts/1.json
  def update
    respond_to do |format|
      if @forecast.save
        format.html { redirect_to forecasts_path(zipcode: @forecast.zipcode), notice: "Forecast was successfully updated." }
        format.json { render :index, status: :ok, location: @forecast }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forecasts/1 or /forecasts/1.json
  def destroy
    @forecast.destroy!

    respond_to do |format|
      format.html { redirect_to forecasts_url, notice: "Forecast was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_forecast
      if params["forecast"].nil?
        @forecast = Forecast.new
      else
        param_fields = params["forecast"]
        zipcode = param_fields["zipcode"]
        @forecast = Forecast.find_by(zipcode: zipcode) || Forecast.new(zipcode: zipcode)
      end
      weather_forecast = WeatherForecastService::Forecast.new.call(location: zipcode)
      @forecast.assign_attributes(weather_forecast) if zipcode
    end

    # Only allow a list of trusted parameters through.
    def forecast_params
      params.permit('forecast').permit('zipcode')
    end
end
