class UserHabit < ApplicationRecord
  belongs_to :user
  belongs_to :habit
  has_one :streak

  validates_presence_of :user_id,
                        :habit_id,
                        :status,
                        :goal_int,
                        :goal_type,
                        :started_date,
                        :times_completed,
                        :days_completed,
                        :weeks_completed

  validates_numericality_of :user_id,
                            :habit_id,
                            :goal_int,
                            :times_completed,
                            :days_completed,
                            :weeks_completed

  enum status: [:inactive, :active]
  enum goal_type: [:day, :week]

  def update_user_habit
    if goal_type == 'day'
      update!(times_completed: 0, days_completed: self.days_completed += 1)
    else
      update!(times_completed: 0, weeks_completed: self.weeks_completed += 1)
    end
  end

  def check_user_habit_streak
    if light_streak_eligible?
      Streak.create!(user_habit_id: id, streak_type: 0)
    elsif fire_streak_eligible?
      streak.update!(streak_type: 1)
    end
  end

  def light_streak_eligible?
    streak.nil? && (days_completed >= 3 || weeks_completed >= 3)
  end

  def fire_streak_eligible?
    (days_completed >= 10 || weeks_completed >= 10)
  end
end
