class HabitSerializer
  def self.serialized_json(all_habits)
    {
      "data": all_habits.map do |habit|
        {
          "id": habit.id,
          "name": habit.name,
          "category": habit.category
        }
      end
    }
  end
end