class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.ordered_projects.to_a
  end

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
      redirect_to projects_url
    else
      flash[:errors] = @project.errors.full_messages
      redirect_to new_project_url
    end
  end

  def show
    @project = Project.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:title,
                                    :pattern_url,
                                    :category,
                                    :status,
                                    tool_ids: [])
  end
end
