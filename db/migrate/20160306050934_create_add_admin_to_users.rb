class CreateAddAdminToUsers < ActiveRecord::Migration
  def change
    create_table :add_admin_to_users do |t|

      t.timestamps null: false
    end
  end
end
