class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[like]

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

  def like
    # TODO: Use Sidkiq to optimize this feature
    @result = current_user.toggle_like(@post)

    @message = if @result
                "liked"
              else
                "disliked"
              end

    render template: "posts/like.json.jbuilder", status: :ok
  end

  private

  def post_params
    params.require(:post).permit(:text, :project_id)
  end

  def set_post
    @post = Post.find_by(id: params[:id])

    if @post.nil?
      flash[:errors] = ["Post was not found"]
      redirect_back fallback_location: root_path
    end
  end
end
