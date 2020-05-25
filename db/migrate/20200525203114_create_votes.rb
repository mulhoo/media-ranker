class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.date :date
      t.bigint :work_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
