class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :user_name
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :phone
      t.string :program
      t.string :contact_method
      t.integer :year

      t.timestamps
    end
  end
end
