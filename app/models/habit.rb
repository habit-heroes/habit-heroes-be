class Habit < ApplicationRecord
  has_many :user_habits
  has_many :users, through: :user_habits

  validates_presence_of :name, :category

  enum category: [:dental, :sleep, :productivity, :hydration, :hobby, :exercise]
end
