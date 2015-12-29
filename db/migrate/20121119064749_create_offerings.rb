class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.integer :user_id
      t.integer :course_id
      t.decimal :price, :precision => 6, :scale => 2

      t.timestamps
    end
  end
end
