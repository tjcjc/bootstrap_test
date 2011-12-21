class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :subject_id, :integer
  end
end
