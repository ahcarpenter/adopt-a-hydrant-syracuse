class SMS
  @@account_sid = 'AC0b322d7367604e7a852a1d59193738a2'
  @@auth_token = 'c32bcf082cb7cee728a99832858db23b'
  @@client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
  @@account = @@client.account

  def self.send_notification(user, thing)
    extra = (110-(thing.snow_cover.to_s.length+thing.full_address.length))
    thing_name_length = thing.name.length
    requested = user.name.length+thing_name_length
    if requested < extra
      @@account.sms.messages.create(:from => '+18599030353', :to => user.sms_number, :body => user.name + ', ' + thing.name + ' might be surrounded by ' + thing.snow_cover.to_s + ' in. of snow. Location: ' + thing.full_address + '.')
    else
      requested_extra_difference = requested-extra
      @@account.sms.messages.create(:from => '+18599030353', :to => user.sms_number, :body => user.name + ', ' + thing.name.truncate(thing_name_length-requested_extra_difference) + ' might be surrounded by ' + thing.snow_cover.to_s + ' in. of snow. Location: ' + thing.full_address + '.') if (requested > extra) && (thing_name_length > requested_extra_difference)
    end
  end
  
  def self.send_referral(referral)
    # @@account.sms.messages.create(:from => '+18599030353', :to => Referee.find(referral.referee_id).endpoint, :body => User.find(referral.user_id).name + ' has referred you to ' + I18n.t('titles.main') + '. You might be interested in checking out the following: http://adopt-a-hydrant-syracuse.herokuapp.com/' + Base64::encode64(referral.id.to_s) + '.')
    @@account.sms.messages.create(:from => '+18599030353', :to => Referee.find(referral.referee_id).endpoint, :body => User.find(referral.user_id).name + ' has referred you to Adopt-a-Hydrant. You might be interested in checking out the following: http://adopt-a-hydrant-syracuse.herokuapp.com/' + Base64::encode64(referral.id.to_s).chop + '.')
  end
end