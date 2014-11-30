class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :content
      t.decimal :latitude, :decimal, :precision => 9, :scale => 3
      t.decimal :longitude, :decimal, :precision => 9, :scale => 3
      t.integer :good, :default => 0
      t.integer :bad, :default => 0

      t.timestamps
    end
  end
end