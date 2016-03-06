class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.references :program, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
