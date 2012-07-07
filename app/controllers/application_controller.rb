# http://www.dzone.com/snippets/ruby-open-file-write-it-and
# http://www.ruby-doc.org/core-1.9.3/Hash.html
# http://rails-bestpractices.com/posts/47-fetch-current-user-in-models
# http://stackoverflow.com/questions/5226946/rails3-http-user-agent
# https://github.com/arsduo/koala/wiki/OAuth
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_flash_from_params
  before_filter :set_locale
  
protected
  def set_current_user
    User.current = current_user
  end
  def set_flash_from_params
    if params[:flash]
      params[:flash].each do |key, message|
        if message.include? 'notices'
          I18n.locale = cookies[:locale]
          flash.now[key.to_sym] = I18n.t(message)
        else
          flash.now[key.to_sym] = message
        end
      end
    end
  end

  def set_locale
    @@oauth = Koala::Facebook::OAuth.new(255900427854057, '8efe989aeb23f1206c40362da5795ba0', 'http://adopt-a-hydrant-syracuse.herokuapp.com/')
    if request.env['HTTP_USER_AGENT'].include? 'Mobile'
      session[:url_for_oauth_code] = @@oauth.url_for_oauth_code(:permissions=>'publish_stream', :permissions=>'email', :callback_url=>'http://adopt-a-hydrant-syracuse.herokuapp.com/', :display=>'touch')
    else
      session[:url_for_oauth_code] = @@oauth.url_for_oauth_code(:permissions=>'publish_stream', :permissions=>'email', :callback_url=>'http://adopt-a-hydrant-syracuse.herokuapp.com/')
    end
    
    available_languages = Dir.glob(Rails.root + 'config/locales/??.yml').map do |file|
      File.basename(file, '.yml')
    end
    
    locale_token_in_uri = true if ((params[:locale] == 'ar') || (params[:locale] == 'cn') || (params[:locale] == 'de') || (params[:locale] == 'en') || (params[:locale] == 'es') || (params[:locale] == 'fr') || (params[:locale] == 'gr') || (params[:locale] == 'ht') || (params[:locale] == 'iw') || (params[:locale] == 'it') || (params[:locale] == 'kr') || (params[:locale] == 'pl') || (params[:locale] == 'pt') || (params[:locale] == 'ru') || (params[:locale] == 'yi'))
    
    Referral.resolve_token(params[:locale]) if !locale_token_in_uri && !params[:locale].nil?
    
    cookies[:locale] = params[:locale]  if locale_token_in_uri
    
    I18n.locale = cookies[:locale] || I18n.default_locale
  end
end