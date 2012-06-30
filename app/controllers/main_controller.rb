class MainController < ApplicationController
  before_filter :set_current_user
    
  def index
    @app_name = t('titles.main')
    ReferThis.url(params[:referral], User.current.id, request.base_url, User.current.name, @app_name) if !params[:referral].nil?
    
    @required = Sidebar.translate_required if @required.nil?
    @sms_notifications = Sidebar.translate_sms_notifications if @sms_notifications.nil?
  end
end