class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.add(comment_params, current_user)

    @errors = @comment.errors.full_messages

    status = :ok

    unless @errors.empty?
      status = :unprocessable_entity
    end

    render template: "comments/show.json.jbuilder", status: status
  end

  def comment_params
    params.require(:comment).permit(:text, :project_id, :post_id)
  end
end
