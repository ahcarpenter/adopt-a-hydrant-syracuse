# https://github.com/arsduo/koala/wiki/OAuth
# https://github.com/arsduo/koala/wiki/Graph-API
class MainController < ApplicationController
  before_filter :set_current_user
    
  def index
    ReferThis.url(params[:referral], User.current.id, request.base_url, User.current.name, 'Adopt-a-Hydrant') if !params[:referral].nil?
    if !request[:code].nil?
      @graph = Koala::Facebook::API.new(@@oauth.get_access_token(request[:code]))
      profile = @graph.get_object('me')
      User.exists?(:facebook_id=>profile['id']) ? sign_in('user', User.find_by_facebook_id(profile['id']).update1(profile['name'], profile['id'], profile['email'])) : sign_in('user', User.new1.update1(profile['name'], profile['id'], profile['email']))
    end
    
    @required = Sidebar.translate_required if @required.nil?
    @sms_notifications = Sidebar.translate_sms_notifications if @sms_notifications.nil?
  end
end