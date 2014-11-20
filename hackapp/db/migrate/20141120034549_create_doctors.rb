class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :crm
      t.string :address
      t.string :city
      t.string :neighborhood
      t.text :healthPlans
      t.integer :callendarId

      t.timestamps
    end
  end
end
