class CallsController
  def index
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hello', :voice => 'woman'
      r.Dial :callerId => '+16463976583' do |d|
        d.Client 'Drew'
      end
    end
    puts response.text
  end
end