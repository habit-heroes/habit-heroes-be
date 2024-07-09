class Streak < ApplicationRecord
  belongs_to :user_habit

  validates_presence_of :user_habit_id, :type
  validates_numericality_of :user_habit_id, :type

  enum type: [:light, :fire]
end
