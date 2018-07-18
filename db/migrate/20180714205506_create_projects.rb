class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :pattern_url
      t.string :category
      t.string :status, default: "New"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
