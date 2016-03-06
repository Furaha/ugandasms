class CreateAddAdminToUsers < ActiveRecord::Migration
  def change
    create_table :add_admin_to_users do |t|
      add_column :users, :admin, :boolean
    end
  end
end
