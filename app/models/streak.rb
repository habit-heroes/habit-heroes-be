class Streak < ApplicationRecord
  belongs_to :user_habit
  has_one :user, through: :user_habit

  validates_presence_of :user_habit_id, :streak_type
  validates_numericality_of :user_habit_id

  enum streak_type: [:light, :fire]
end
