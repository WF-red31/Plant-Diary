class RemoveGroupIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :group_id, :integer
  end
end
