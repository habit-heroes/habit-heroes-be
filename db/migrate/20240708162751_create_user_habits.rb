class CreateUserHabits < ActiveRecord::Migration[7.1]
  def change
    create_table :user_habits do |t|
      t.references :user, null: false, foreign_key: true
      t.references :habit, null: false, foreign_key: true
      t.integer :status
      t.integer :goal_int
      t.integer :goal_type
      t.string :started_date
      t.integer :times_completed
      t.integer :days_completed
      t.integer :weeks_completed

      t.timestamps
    end
  end
end
