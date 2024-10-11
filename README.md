# README
hello

Weather Forcasts powered by www.visualcrossing.com

Enter Zipcode and get a weather forcast 


----
### Setup
- Clone the repo
- run `bundle install`
- edit `config/application.yml` with your own visualcrossing key the one here is my trial one which will expire eventually.
- Migrate the database (you may need to create a postgres DB. Make sure the PG gem is installed)
  - `bundle exec rake db:migrate RAILS_ENV=development`
  - `bundle exec rake db:migrate RAILS_ENV=test`
- start the server `bundle exec rails s -b 0.0.0.0`
- navigate to `http://localhost:3000/` or `http://localhost:3000/forecasts`

### TODO
- change the db column from zipcode to location
- add text explaining that the input can ALSO be partial or full address, lat lon
- move the api key to the credentials.yml
- hide the forecast table if there is no forecast
- show the the time the forecast was last updated
- show the five day forecast(field is already in the mapper, just not enabled)
- add controller spec for `get_forecast` method
- add request specs for `/forecasts` actions `view` and `create`
- add options for more elements to be added to the view of a forecast. 
- Ambitious: A scheduled task that reads the Forecast table every 40 minutes and if a record has not been update in the last 30 minutes then kickoff a sidekiq worker that calls the api with that records locationso as to update it.
