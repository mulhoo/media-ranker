class AddIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index :votes, :user_id
    add_index :votes, :work_id

    add_foreign_key :votes, :users
    add_foreign_key :votes, :works
  end
end
