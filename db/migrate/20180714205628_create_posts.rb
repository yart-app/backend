class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :text
      t.references :project, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
