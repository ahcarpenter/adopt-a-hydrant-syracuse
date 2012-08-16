class CallsController < ApplicationController
  def test
    # response = Twilio::TwiML::Response.new do |r|
    #       r.Say = 'Test', :voice=>'woman'
    #     end
    @post_to = 'http://localhost:3000/calls/directions'
    render :action=>'calls.xml.builder', :layout=>false
  end
  
  def directions
    if params['Digits'] == '3'
      puts 'Hello'
    end
    
    if !params['Digits'] or params['Digits'] != '2'
      redirect_to :action=>'test'
      return
    end
    
    @redirect_to = 'http://localhost:3000/calls/test'
    render :action=>'directions.xml.builder', :layout=>false
  end
end