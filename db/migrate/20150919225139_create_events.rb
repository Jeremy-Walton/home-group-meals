class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :name
      t.date :date
      t.string :description

      t.timestamps
    end
  end
end
