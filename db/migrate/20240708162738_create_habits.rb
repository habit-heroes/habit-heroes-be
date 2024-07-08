class CreateHabits < ActiveRecord::Migration[7.1]
  def change
    create_table :habits do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
