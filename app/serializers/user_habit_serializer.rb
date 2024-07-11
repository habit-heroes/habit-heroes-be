class UserHabitSerializer
  def self.serialized_json_user_list(user)
    {
      "data": user.user_habits.map do |user_habit|
        {
          "id": user_habit.id,
          "name": user_habit.habit.name,
          "status": user_habit.status,
          "goal_int": user_habit.goal_int,
          "goal_type": user_habit.goal_type,
          "started_date": user_habit.started_date,
          "times_completed": user_habit.times_completed,
          "days_completed": user_habit.days_completed,
          "weeks_completed": user_habit.weeks_completed
        }
      end
    }
  end

  def self.serialized_json_created(user_habit)
    {
      "data":
        {
          "id": user_habit.id,
          "name": user_habit.habit.name,
          "status": user_habit.status,
          "goal_int": user_habit.goal_int,
          "goal_type": user_habit.goal_type,
          "started_date": user_habit.started_date,
          "times_completed": user_habit.times_completed,
          "days_completed": user_habit.days_completed,
          "weeks_completed": user_habit.weeks_completed
        }
    }
  end
end