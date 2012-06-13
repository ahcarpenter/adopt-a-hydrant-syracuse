# http://guides.rubyonrails.org/migrations.html
class RemoveVoiceNumberFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :voice_number
  end

  def down
    add_column :users, :voice_number, :string
  end
end
