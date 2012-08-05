# http://stackoverflow.com/questions/6021372/best-way-to-create-unique-token-in-rails
class ThingMailer < ActionMailer::Base
  default :from => 'adoptahydrantsyracuse@gmail.com'

  def reminder(thing)
    @thing = thing
    @user = thing.user
    @current_user_name = User.current.name
    mail {:to => thing.user.email,:subject => thing.name}
  end
  
  def notify(thing)
    mail :to => thing.user.email, :from => 'adoptahydrantsyracuse@gmail.com', :subject => thing.name, :body => thing.user.name + ', ' + thing.name + ' might be surrounded by ' + thing.snow_cover.to_s + ' in. of snow. Location: ' + thing.full_address + '.'
  end
end