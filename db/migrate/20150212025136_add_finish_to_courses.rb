class AddFinishToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :finish, :boolean, default: false
  end
end
