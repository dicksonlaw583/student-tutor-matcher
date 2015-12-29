class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.string :user_name
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :phone
      t.decimal :cgpa
      t.string :education_level
      t.string :contact_method
      t.string :personal_description

      t.timestamps
    end
  end
end
