class AddProjectToTool < ActiveRecord::Migration[5.2]
  def change
    add_reference :tools, :project, foreign_key: true
  end
end
