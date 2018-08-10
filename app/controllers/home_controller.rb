class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @projects = current_user.ordered_projects.to_a
    @posts = current_user.ordered_posts(include_auto_generated: false).to_a
  end
end
