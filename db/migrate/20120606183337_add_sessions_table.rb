# http://stackoverflow.com/questions/9473808/cookie-overflow-in-rails-application
# http://stackoverflow.com/questions/874634/create-an-activerecord-database-table-with-no-id-column
class AddSessionsTable < ActiveRecord::Migration
  def change
    create_table :sessions, :id => false do |t|
      t.string :session_id, :null => false, :primary_key => true
      t.text :data
      t.timestamps
    end

    add_index :sessions, :session_id
    add_index :sessions, :updated_at
  end
end