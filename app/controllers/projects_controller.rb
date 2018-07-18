class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.where(user: current_user).order(created_at: "desc").to_a
    @project = Project.new
    @categories = Project::Category::OPTIONS
    @statuses = Project::Status::OPTIONS
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    flash[:errors] = @project.errors.full_messages unless @project.save

    redirect_to projects_url
  end

  def project_params
    params.require(:project).permit(:title, :pattern_url, :category, :status)
  end
end
