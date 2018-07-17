class AddUserToTools < ActiveRecord::Migration[5.2]
  def change
    add_reference :tools, :user, foreign_key: true
  end
end
