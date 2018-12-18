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

    redirect_to root_url
  end

  def show; end

  def post_params
    params.require(:post).permit(:text, :project_id)
  end
end
