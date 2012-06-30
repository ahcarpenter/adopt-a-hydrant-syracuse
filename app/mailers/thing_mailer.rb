# http://stackoverflow.com/questions/6021372/best-way-to-create-unique-token-in-rails
class ThingMailer < ActionMailer::Base
  default :from => 'adoptahydrantsyracuse@gmail.com'

  def reminder(thing)
    @thing = thing
    @user = thing.user
    mail(
      {
        :to => thing.user.email,
        :subject => ['Remember to shovel', thing.name].compact.join(' '),
      }
    )
  end
  
  def notify(thing)
    mail(:to => thing.user.email, :from => 'adoptahydrantsyracuse@gmail.com', :subject => thing.name, :body => thing.user.name + ', ' + thing.name + ' might be surrounded by ' + thing.snow_cover.to_s + ' in. of snow. Location: ' + thing.full_address + '.')
  end
end