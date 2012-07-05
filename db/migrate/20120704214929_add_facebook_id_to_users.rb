# https://github.com/arsduo/koala/wiki/Koala-on-Rails
class AddFacebookIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :bigint
  end
end
