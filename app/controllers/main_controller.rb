class MainController < ApplicationController
  before_filter :set_current_user

  def index
    @name = User.find(User.current.id).name if !User.current.nil?
        
    begin
    Referral.generate_referral(params[:referral]) if !params[:referral].nil?
    rescue Net::SMTPSyntaxError
      puts 'Hello'
    end
    
    @required = Sidebar.translate_required if @required.nil?
    @sms_notifications = Sidebar.translate_sms_notifications if @sms_notifications.nil?
  end
end