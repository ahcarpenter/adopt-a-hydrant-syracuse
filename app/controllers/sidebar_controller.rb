class SidebarController < ApplicationController
  def search
    User.current = User.find_by_email(session[:user_email])
  end
  def combo_form
    @required = Sidebar.translate_required if @required.nil?
    @sms_notifications = Sidebar.translate_sms_notifications if @sms_notifications.nil?
  end
end