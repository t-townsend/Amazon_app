class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :review, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :is_up

      t.timestamps
    end
  end
end
