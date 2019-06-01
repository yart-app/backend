class AddOnboardedFieldToUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :onboarded, :boolean, default: false
  end
end
