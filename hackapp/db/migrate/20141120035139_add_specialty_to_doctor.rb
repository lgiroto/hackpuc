class AddSpecialtyToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :specialty, :string
  end
end
