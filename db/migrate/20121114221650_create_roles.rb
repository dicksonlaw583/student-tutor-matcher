class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :homepage_dir

      t.timestamps
    end
  end
end
