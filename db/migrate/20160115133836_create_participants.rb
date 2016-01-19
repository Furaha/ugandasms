class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :number

      t.timestamps null: false
    end
  end
end
