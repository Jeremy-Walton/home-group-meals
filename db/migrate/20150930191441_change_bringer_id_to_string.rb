class ChangeBringerIdToString < ActiveRecord::Migration
  def change
    change_column :items, :bringer,  :string
  end
end
