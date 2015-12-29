class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :favourite_tutor_id
      t.integer :liking_student_id

      t.timestamps
    end
  end
end
