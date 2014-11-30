class AddMyspotToUsers < ActiveRecord::Migration
  def change
    add_column :users, :my_latitude, :decimal, :precision => 9, :scale => 3
    add_column :users, :my_longitude, :decimal, :precision => 9, :scale => 3
  end
end
