class Call
  @@account_sid = 'AC0b322d7367604e7a852a1d59193738a2'
  @@auth_token = 'c32bcf082cb7cee728a99832858db23b'
  @@client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
  @@account = @@client.account
  
  def make_call
    data = {:from => '+18599030353', :to => '+16463976583', :url => 'http://localhost:3000/calls/test'}
    begin
      @@account.calls.create data
    rescue StandardError => bang
      puts 'Hello'
      return
    end
  end
end