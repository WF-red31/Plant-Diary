class CreatePostGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :post_groups do |t|
      
      t.references :post, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
