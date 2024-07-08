class UserHabitSerializer
  def self.serialized_json(user)
    {
      "data": user.user_habits.map do |user_habit|
        {
          "id": user_habit.id,
          "name": user_habit.habit.name,
          "status": user_habit.status,
          "frequency_int": user_habit.frequency_int,
          "frequency_type": user_habit.frequency_type,
          "started_date": user_habit.started_date,
          "times_completed": user_habit.times_completed,
          "days_completed": user_habit.days_completed,
          "weeks_completed": user_habit.weeks_completed
        }
      end
    }
  end
end