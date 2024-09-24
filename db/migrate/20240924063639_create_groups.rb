class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|

      t.timestamps
      t.string :name
      t.text :introduction
      t.integer :user_id
    end
  end
end
