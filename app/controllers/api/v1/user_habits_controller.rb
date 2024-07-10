class Api::V1::UserHabitsController < ApplicationController
  def index
    user = User.find_by(id: params[:id])
    if !user.nil?
      if !user.user_habits.empty?
        render json: UserHabitSerializer.serialized_json_user_list(user), status: :ok
      else
        render json: { data: [] }, status: :ok
      end
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def create # Refactor
    user = User.find_by(id: params[:user_id])
    habit = Habit.find_by(id: params[:habit_id])
    if !user.nil? && !habit.nil?
      if !UserHabit.find_by(user_id: user.id, habit_id: habit.id)
        type = day_or_week(habit)
        int = determine_frequency(type, habit)
        new_habit = UserHabit.create!(
          user_id: user.id,
          habit_id: habit.id,
          status: 1,
          goal_int: int,
          goal_type: type,
          started_date: Time.now,
          times_completed: 0,
          days_completed: 0,
          weeks_completed: 0
        )
        render json: UserHabitSerializer.serialized_json_created(new_habit), status: :created
      else
        render json: { error: "UserHabit already exists" }, status: :conflict
      end
    elsif habit.nil?
      render json: { error: "Habit not found" }, status: :not_found
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private

  def day_or_week(habit) # Refactor
    if habit.category == "hobby" || habit.category == "exercise"
      return 1
    else
      return 0
    end
  end

  def determine_frequency(type, habit) # Refactor
    if type == 0 && habit.category == "dental"
      return 2
    elsif type == 0
      return 1
    else
      return 3
    end
  end
end