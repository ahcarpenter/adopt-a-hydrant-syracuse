class SessionsController < Devise::SessionsController
  def new
    redirect_to root_path
  end

  def create
    session[:user_email] = params[:user][:email]
    resource = warden.authenticate(:scope => resource_name)
    if resource
      sign_in(resource_name, resource)
      render(:json => resource)
    else
      render(:json => {'errors' => {:password => [t('errors.password')]}}, :status => 401)
    end
  end

  def destroy
    signed_in = signed_in?(resource_name)
    sign_out(resource_name) if signed_in
    @oauth = Koala::Facebook::OAuth.new(257793937668716, 'f66a2340122a29bc70f440dabc708130', 'http://localhost:3000/')
    session[:url_for_oauth_code] = @oauth.url_for_oauth_code(:permissions=>'publish_stream', :permissions=>'email', :callback_url=>'http://localhost:3000/')
    render(:json => {'success' => signed_in})
  end
end