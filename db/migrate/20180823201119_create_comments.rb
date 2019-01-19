class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :project, foreign_key: true
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true

      t.string :text
      t.integer :parent_id

      t.timestamps
    end
  end
end
