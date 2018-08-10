class AddFieldsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :updated_field, :string
    add_column :posts, :updated_value, :string
    add_reference :posts, :user, foreign_key: true
    add_column :posts, :auto_generated, :boolean, default: false
  end
end
