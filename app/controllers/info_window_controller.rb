# http://oldwiki.rubyonrails.org/rails/pages/HowtoWorkWithSessions
class InfoWindowController < ApplicationController
  def index
    session[:thing] = Thing.find_by_id(params[:thing_id])
    session[:thing] = Thing.find_by_id(session[:id]) if session[:thing].nil?
    
    if session[:thing].adopted?
      session[:conflict] == true ? render('users/conflict') : render('users/thank_you') if user_signed_in? && current_user.id == session[:thing].user_id
    else
      user_signed_in? ? render('things/adopt') : render('users/sign_in')
    end
  end
end