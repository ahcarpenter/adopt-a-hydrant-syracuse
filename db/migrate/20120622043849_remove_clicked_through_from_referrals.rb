class RemoveClickedThroughFromReferrals < ActiveRecord::Migration
  def up
    remove_column :referrals, :clicked_through
  end

  def down
    add_column :referrals, :clicked_through, :bool
  end
end