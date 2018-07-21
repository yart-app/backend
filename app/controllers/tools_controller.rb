class ToolsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tools = Tool.where(user: current_user).order(created_at: "desc").to_a
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.images.attach(params["tool"]["images"])
    @tool.user = current_user
    @tool.save

    if @tool.errors.empty?
      redirect_to tools_url
    else
      flash[:errors] = @tool.errors.full_messages
      redirect_to new_tool_url
    end
  end

  def tool_params
    params.require(:tool).permit(:name, :description, :url)
  end
end
