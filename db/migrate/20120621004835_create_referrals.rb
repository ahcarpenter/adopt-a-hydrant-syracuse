class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      # t.string :medium, :null => false
      t.boolean :clicked_through, :default => false
      t.integer :referee_id
      t.integer :user_id

      t.timestamps
    end
  end
end