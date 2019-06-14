class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :reset_session
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :html, :json

  def initialize
    super
    @errors = []
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[
      name
      username
      email
      password
      password_confirmation
      remember_me
      avatar
    ]

    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def set_page
    @page = params[:page] || 1
  end
end
