class AddPropertiesToUsers < ActiveRecord::Migration
  def change
	add_column :users, :first_name, :string
	add_column :users, :last_name, :string
	add_column :users, :address, :string
	add_column :users, :phone, :string
	add_column :users, :program, :string
	add_column :users, :contact_method, :string
	add_column :users, :year, :integer
	add_column :users, :cgpa, :decimal
	add_column :users, :education_level, :string
	add_column :users, :personal_description, :string
	
  end
end
