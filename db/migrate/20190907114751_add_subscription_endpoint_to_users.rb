class AddSubscriptionEndpointToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notification_subscription_endpoint, :string
  end
end
