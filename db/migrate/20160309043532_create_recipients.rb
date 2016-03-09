class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :name
      t.string :number
      t.references :program

      t.timestamps null: false
    end
  end
end
