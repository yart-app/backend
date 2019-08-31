class HomeController < ApplicationController
  def index
    @post = Post.new

    ordered_projects = current_user.ordered_projects

    @projects = ordered_projects.to_a
    @posts = current_user.ordered_posts_with_friends_posts.to_a
  end
end
