class AddLatitudeAndLongitudeToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :latitude, :float
    add_column :doctors, :longitude, :float
  end
end
