class RemoveKeys < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :votes, :users
    remove_foreign_key :votes, :works
  end
end
