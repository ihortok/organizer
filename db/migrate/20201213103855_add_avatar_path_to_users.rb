class AddAvatarPathToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar_path, :string, default: 'uploads/user.png'
  end
end
