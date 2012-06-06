#http://railscasts.com/episodes/59-optimistic-locking
class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.timestamps
      t.string :name
      t.decimal :lat, :null => false, :precision => 18, :scale => 14
      t.decimal :lng, :null => false, :precision => 18, :scale => 14
      t.integer :user_id
      t.decimal :snow_cover, :default => 0, :precision => 5, :scale => 2
    end
  end
end