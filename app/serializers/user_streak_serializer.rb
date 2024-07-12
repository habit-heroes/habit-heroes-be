class UserStreakSerializer
  def self.serialized_json_user_list(user)
    {
      "data": user.streaks.map do |streak|
        {
          "id": streak.id,
          "name": streak.user_habit.habit.name,
          "category": streak.user_habit.habit.category,
          "goal_type": streak.user_habit.goal_type,
          "streak_type": streak.streak_type,
          "days_or_weeks_completed": streak.days_or_weeks_completed
        }
      end
    }
  end
end