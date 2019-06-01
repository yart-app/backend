class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, except: %i[index new create]
  after_action :finish_user_onboarding, only: %i[show]

  def index
    @project = Project.new
    @categories = Project::Category::OPTIONS
    @statuses = Project::Status::OPTIONS
    @tools = current_user.tools

    @projects = current_user.ordered_projects.to_a
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
    @categories = Project::Category::OPTIONS
    @statuses = Project::Status::OPTIONS
    @posts = @project.posts.to_a
  end

  def update_status
    unless @project.update_status(params[:status])
      flash[:errors] = @project.errors.full_messages
      redirect_to project_path(@project)
    end
  end

  def update_category
    unless @project.update_category(params[:category])
      flash[:errors] = @project.errors.full_messages
      redirect_to project_path(@project)
    end
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

  def finish_user_onboarding
    user = current_user
    return if user.onboarded

    user.set_as_onboarded
  end
end
