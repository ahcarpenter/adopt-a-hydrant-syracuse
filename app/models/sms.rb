class SMS
  @@account_sid = 'AC0b322d7367604e7a852a1d59193738a2'
  @@auth_token = 'c32bcf082cb7cee728a99832858db23b'
  @@client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
  @@account = @@client.account

  def send_notification(user, thing, greatest_amount_of_snowfall_forecasted)
    extra = (101-(greatest_amount_of_snowfall_forecasted.to_s.length+thing.full_address.length))
    thing_name_length = thing.name.length
    requested = user.name.length+thing_name_length
    if requested < extra
      @@account.sms.messages.create(:from => '+18599030353', :to => user.sms_number, :body => user.name + ', look out for ' + thing.name + '! Forecasted snowfall: ' + greatest_amount_of_snowfall_forecasted.to_s + ' inches. Location: ' + thing.full_address + '.')
    else
      requested_extra_difference = requested-extra
      @@account.sms.messages.create(:from => '+18599030353', :to => user.sms_number, :body => user.name + ', look out for ' + thing.name.truncate(thing_name_length-requested_extra_difference) + ' ! Forecasted snowfall: ' + greatest_amount_of_snowfall_forecasted.to_s + ' inches. Location: ' + thing.full_address + '.') if (requested > extra) && (thing_name_length > requested_extra_difference)
    end
  end
end