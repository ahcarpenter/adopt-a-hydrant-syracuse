class MainController < ApplicationController
  before_filter :set_current_user

  def index
    @name = User.find(User.current.id).name if !User.current.nil?
    @portion_of_preview = ' has referred you to Adopt-a-Hydrant. You might be interested in checking out the following: http://adopt-a-hydrant-syracuse.herokuapp.com/' + Base64::encode64(((Referral.all.last.id)+1).to_s).chop + '.'
    
    begin
    Referral.generate_referral(params[:referral]) if !params[:referral].nil?
    rescue Net::SMTPSyntaxError
      puts 'Hello'
    end
    
    @required = Sidebar.translate_required if @required.nil?
    @sms_notifications = Sidebar.translate_sms_notifications if @sms_notifications.nil?
  end
end