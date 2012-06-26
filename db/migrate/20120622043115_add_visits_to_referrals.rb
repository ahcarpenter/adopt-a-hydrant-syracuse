class AddVisitsToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :visits, :integer, :default => 0
  end
end