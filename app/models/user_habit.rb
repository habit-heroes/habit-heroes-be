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
end
