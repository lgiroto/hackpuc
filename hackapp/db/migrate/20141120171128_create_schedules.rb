class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :calendarID
      t.integer :userID
      t.string :date
      t.integer :hour

      t.timestamps
    end
  end
end
