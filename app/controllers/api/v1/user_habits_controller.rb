class Api::V1::UserHabitsController < ApplicationController
  def index # Refactor
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
        new_habit = UserHabit.create!(
          user_id: user.id,
          habit_id: habit.id,
          status: 1,
          goal_int: habit.determine_frequency,
          goal_type: habit.week_type,
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

  def update # Refactor
    user_habit = UserHabit.find_by(id: params[:user_habit_id])
    if !user_habit.nil?
      if user_habit.status == "active"
        if user_habit.times_completed + 1 == user_habit.goal_int
          user_habit.update_user_habit
          user_habit.check_user_habit_streak
          render json: UserHabitSerializer.serialized_json_created(user_habit), status: :ok
        else
          user_habit.update!(times_completed: user_habit.times_completed += 1)
          render json: UserHabitSerializer.serialized_json_created(user_habit), status: :ok
        end
      else
        render json: { error: "The status of this UserHabit is inactive" }, status: :conflict
      end
    else
      render json: { error: "UserHabit not found" }, status: :not_found
    end
  end
end