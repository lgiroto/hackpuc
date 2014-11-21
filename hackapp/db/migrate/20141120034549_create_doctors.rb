class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :password
      t.string :specialty
      t.string :crm
      t.string :address
      t.string :city
      t.string :neighborhood
      t.string :healthPlans
      t.integer :calendarID

      t.timestamps
    end
  end
end
