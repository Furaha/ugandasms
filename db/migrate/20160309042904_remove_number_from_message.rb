class RemoveNumberFromMessage < ActiveRecord::Migration
  def change
    remove_column :messages, :number, :string
  end
end
