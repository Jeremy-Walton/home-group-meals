class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :name
      t.integer :bringer

      t.timestamps
    end
  end
end
