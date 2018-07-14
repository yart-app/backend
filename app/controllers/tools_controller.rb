class ToolsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tools = Tool.where(user: current_user).order(created_at: 'desc').to_a
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.images.attach(params['tool']['images'])
    @tool.user = current_user

    unless @tool.save
      @errors = @tool.errors.full_messages
    end

    redirect_to tools_url
  end

  def tool_params
    params.require(:tool).permit(:name, :description, :url)
  end
end
