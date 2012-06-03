# https://devcenter.heroku.com/articles/scheduler
# http://graphical.weather.gov/xml/rest.php
# http://api.rubyonrails.org/classes/String.html#method-i-truncate
desc 'This task is called by the Heroku scheduler add-on'
task :update_feed => :environment do
  if Thing.where('user_id IS NOT NULL').any?
    @Weather = Weather.new
    @SMS = SMS.new
    
    Thing.where('user_id IS NOT NULL').find_each do |thing|
      greatest_amount_of_snow_cover_forecasted = Weather.get_snow_cover(thing.lat, thing.lng)
      @user = User.find(thing.user_id) if greatest_amount_of_snow_cover_forecasted > 0.00
      @SMS.send_notification(@user, thing, greatest_amount_of_snow_cover_forecasted) if !@user.nil?
    end
  end
end