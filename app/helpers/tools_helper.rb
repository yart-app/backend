module ToolsHelper
  def hook_title(category)
    if category == Project::Category::CROCHET
      return "Hooks"
    end

    "Needles"
  end
end
