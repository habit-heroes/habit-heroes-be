class Habit < ApplicationRecord
  has_many :user_habits
  has_many :users, through: :user_habits

  validates_presence_of :name, :category

  enum category: [:dental, :sleep, :productivity, :hydration, :hobby, :exercise]

  def week_type
    if category == "hobby" || category == "exercise"
      return 1
    else
      return 0
    end
  end

  def determine_frequency
    if week_type == 0 && category == "dental"
      return 2
    elsif week_type == 0
      return 1
    else
      return 3
    end
  end
end
