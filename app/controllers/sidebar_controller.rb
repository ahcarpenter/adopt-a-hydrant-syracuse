class SidebarController < ApplicationController
  def search
    session[:count] += 1
    flash[:notice] = I18n.t('notices.signed_in') if session[:count] == 2
    User.current = User.find_by_email(session[:user_email])
  end
  def combo_form
    @required = Sidebar.translate_required if @required.nil?
    @sms_notifications = Sidebar.translate_sms_notifications if @sms_notifications.nil?
  end
end