class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating_user_id
      t.integer :rated_user_id
      t.integer :amount
      t.string :comment

      t.timestamps
    end
  end
end
