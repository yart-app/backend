class SessionsController <  Devise::SessionsController
  def after_sign_in_path_for(resource)
    return projects_path if resource.onboarded == false

    root_path
  end
end
