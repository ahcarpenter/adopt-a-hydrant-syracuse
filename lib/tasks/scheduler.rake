# https://devcenter.heroku.com/articles/scheduler
# http://graphical.weather.gov/xml/rest.php
# http://api.rubyonrails.org/classes/String.html#method-i-truncate
desc 'This task is called by the Heroku scheduler add-on'
task :update => :environment do
  
  Thing.all.each do |thing|
    greatest_amount_of_snow_cover_forecasted = Weather.get_snow_cover(thing.lat, thing.lng)
    if thing.snow_cover != greatest_amount_of_snow_cover_forecasted
      thing.snow_cover = greatest_amount_of_snow_cover_forecasted
      thing.save
    end
  end
  
  if Thing.where('user_id IS NOT NULL').any?
    
    Thing.where('user_id IS NOT NULL').find_each do |thing|
      @user = User.find(thing.user_id) if thing.snow_cover > 0.00
      SMS.send_notification(@user, thing) if !@user.nil?
    end
  end
end