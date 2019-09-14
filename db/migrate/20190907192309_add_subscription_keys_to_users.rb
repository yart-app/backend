class AddSubscriptionKeysToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :p256dh_key, :string
    add_column :users, :auth_key, :string
  end
end
