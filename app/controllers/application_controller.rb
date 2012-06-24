# http://www.dzone.com/snippets/ruby-open-file-write-it-and
# http://www.ruby-doc.org/core-1.9.3/Hash.html
# http://rails-bestpractices.com/posts/47-fetch-current-user-in-models
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
          flash.now[key.to_sym] = I18n.t(message)
        else
          flash.now[key.to_sym] = message
        end
      end
    end
  end

  def set_locale
    available_languages = Dir.glob(Rails.root + 'config/locales/??.yml').map do |file|
      File.basename(file, '.yml')
    end
    
    locale_token_in_uri = true if ((params[:locale] == 'ar') || (params[:locale] == 'cn') || (params[:locale] == 'de') || (params[:locale] == 'en') || (params[:locale] == 'es') || (params[:locale] == 'fr') || (params[:locale] == 'gr') || (params[:locale] == 'ht') || (params[:locale] == 'iw') || (params[:locale] == 'it') || (params[:locale] == 'kr') || (params[:locale] == 'pl') || (params[:locale] == 'pt') || (params[:locale] == 'ru') || (params[:locale] == 'yi'))
    
    Referral.resolve_token(params[:locale]) if !locale_token_in_uri && !params[:locale].nil?
    
    cookies[:locale] = params[:locale]  if locale_token_in_uri
    
    I18n.locale = cookies[:locale] || I18n.default_locale
  end
end