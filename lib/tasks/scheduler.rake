# https://devcenter.heroku.com/articles/scheduler
# http://graphical.weather.gov/xml/rest.php
# http://api.rubyonrails.org/classes/String.html#method-i-truncate
# http://www.ruby-doc.org/docs/ProgrammingRuby/html/tut_threads.html
# http://guides.rubyonrails.org/action_mailer_basics.html
desc 'This task is called by the Heroku scheduler add-on'
task :update => :environment do
  threads = []
  things = []
  @weather = Weather.new
  id = 1
  
  14.times {|i|
    things[i] = Thing.where("id > #{id-1}").where("id < #{id=id+79}")
    threads << Thread.new(i) {
      for thing in things[i]
        greatest_amount_of_snow_cover_forecasted = @weather.get_snow_cover(thing.lat, thing.lng)
        if thing.snow_cover != greatest_amount_of_snow_cover_forecasted
          thing.snow_cover = greatest_amount_of_snow_cover_forecasted
          thing.save
        end
      end
    }
  }
  
  threads.each {|thread| thread.join}
  
  if Thing.where('user_id IS NOT NULL').any?
    Thing.where('user_id IS NOT NULL').find_each do |thing|
      @user = User.find(thing.user_id) if thing.snow_cover > 0.00
      SMS.send_notification(@user, thing) if !@user.nil? && thing.sms_notifications
      ThingMailer.notify(thing).deliver if !@user.nil? && thing.email_notifications
    end
  end
end
