class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.create(comment_params)
    @errors = @comment.errors.full_messages
    redirect_back fallback_location: root_path
  end

  def comment_params
    params.require(:comment).permit(:text, :project_id, :post_id, :user_id)
  end
end
