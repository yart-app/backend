class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @posts = @user.posts
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:errors] = ["User was not found"]
      redirect_back fallback_location: root_path
    end
  end
end
