class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: %[show]
  before_action :set_project, except: %i[index new create]

  def new
    @project = Project.new
    @categories = Project::Category::OPTIONS
    @statuses = Project::Status::OPTIONS
    @tools = current_user.tools
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.save

    if @project.errors.empty?
      redirect_to project_url(@project.id)
    else
      flash[:errors] = @project.errors.full_messages
      redirect_to new_project_url
    end
  end

  def show
    @categories = Project::Category::OPTIONS
    @statuses = Project::Status::OPTIONS
    @posts = @project.posts.to_a
  end

  def update_by_field
    result = @project.update_by_field(
      key: params[:key],
      value: params[:value],
    )

    unless result[:status]
      flash[:errors] = @project.errors.full_messages
      redirect_to project_path(@project) && return
    end

    @post = result[:generated_post]
    render template: "posts/show.json.jbuilder", status: :ok
  end

  private

  def set_project
    @project = Project.find_by(id: params[:id])

    if @project.nil?
      flash[:errors] = ["Project was not found"]
      redirect_back fallback_location: projects_path
    end
  end

  def project_params
    params.require(:project).permit(:title,
                                    :pattern_url,
                                    :category,
                                    :status,
                                    tool_ids: [])
  end
end
