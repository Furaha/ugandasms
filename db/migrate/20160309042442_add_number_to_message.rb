class AddNumberToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :number, :string
  end
end
