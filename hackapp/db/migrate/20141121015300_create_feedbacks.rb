class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :rating
      t.text :review
      t.integer :userID

      t.timestamps
    end
  end
end
