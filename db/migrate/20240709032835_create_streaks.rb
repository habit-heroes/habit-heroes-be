class CreateStreaks < ActiveRecord::Migration[7.1]
  def change
    create_table :streaks do |t|
      t.references :user_habit, null: false, foreign_key: true
      t.integer :type

      t.timestamps
    end
  end
end
