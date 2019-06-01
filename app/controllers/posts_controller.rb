class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.new(post_params)
    @post.auto_generated = false
    @post.image.attach(params["post"]["image"])
    @post.user = current_user
    @post.save

    unless @post.errors.empty?
      flash[:errors] = @post.errors.full_messages
    end

    redirect_to after_create_path
  end

  def show; end

  def post_params
    params.require(:post).permit(:text, :project_id)
  end

  def after_create_path
    if !current_user.onboarded && @post.project
      return project_url(@post.project)
    end

    root_url
  end
end
