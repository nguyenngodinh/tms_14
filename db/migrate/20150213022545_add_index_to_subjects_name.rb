class AddIndexToSubjectsName < ActiveRecord::Migration
  def change
    add_index :subjects, :name, unique: true
  end
end
