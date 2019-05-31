class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new

    ordered_projects = current_user.ordered_projects

    @projects = current_user.undone_projects(ordered_projects).to_a
    @posts = current_user.ordered_posts_with_friends_posts.to_a
  end
end
