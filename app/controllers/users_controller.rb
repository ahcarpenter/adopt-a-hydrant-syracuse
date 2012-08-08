class UsersController < Devise::RegistrationsController
  def edit
    render('sidebar/edit_profile', :layout => 'sidebar')
  end
  
  def update
    sign_in(resource_name, resource, :bypass => true) if resource.update_without_password(params[resource_name])
    if resource.update_without_password(params[resource_name])
      sign_in(resource_name, resource, :bypass => true)
      flash[:notice] = I18n.t('notices.profile_updated')
      redirect_to(:controller => 'sidebar', :action => 'search')
    else
      clean_up_passwords(resource)
      render(:json => {'errors' => resource.errors}, :status => 500)
    end
  end

  def create
    build_resource
    if resource.save
      begin
      sign_in(resource_name, resource)
      rescue ActiveRecord::RecordNotUnique
        flash[:notice] = 'An account with that email address already exists!'
      end
      render(:json => resource)
    else
      clean_up_passwords(resource)
      render(:json => {'errors' => resource.errors}, :status => 500)
    end
  end
end