class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.where(user: current_user).order(created_at: "desc").to_a
    @project = Project.new
  end
end
