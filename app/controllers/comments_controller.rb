class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page, only: [:index]

  def index
    @entity = Post.find_by(id: params[:post_id]) ||
      Project.find_by(id: params[:project_id])

    unless @entity
      @errors << "Please send either post or project id"
      render template: "comments/index.json.jbuilder",
             status: :unprocessable_entity
      return
    end

    @comments = @entity.limited_comments(page: @page)
    render template: "comments/index.json.jbuilder", status: :ok
  end

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
