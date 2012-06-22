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
  
  def send_referral(referral)
    # mail(:to => Referee.find(referral.referee_id).endpoint, :from => 'adoptahydrantsyracuse@gmail.com', :subject => t('titles.main'), :body => User.find(referral.user_id).name + ' has referred you to ' + t('titles.main') + '. You might be interested in checking out the following: http://adopt-a-hydrant-syracuse.herokuapp.com/' + Base64::encode64(referral.id.to_s) + '.')
    mail(:to => Referee.find(referral.referee_id).endpoint, :from => 'adoptahydrantsyracuse@gmail.com', :subject => 'Adopt-a-Hydrant', :body => User.find(referral.user_id).name + ' has referred you to Adopt-a-Hydrant. You might be interested in checking out the following: http://adopt-a-hydrant-syracuse.herokuapp.com/' + Base64::encode64(referral.id.to_s) + '.')
  end
end