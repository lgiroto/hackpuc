class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.timestamp :date
      t.integer :calendarID

      t.timestamps
    end
  end
end
