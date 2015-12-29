class AddProfessorNameToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :professor_name, :string

  end
end
