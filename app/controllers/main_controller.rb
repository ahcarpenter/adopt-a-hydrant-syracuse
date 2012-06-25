class MainController < ApplicationController
  def index
    begin
    Referral.generate_referral(params[:referral]) if !params[:referral].nil?
    rescue Net::SMTPSyntaxError
      puts 'Hello'
    end
    
    @required = Sidebar.translate_required if @required.nil?
    @sms_notifications = Sidebar.translate_sms_notifications if @sms_notifications.nil?
  end
end