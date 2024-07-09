class Api::V1::HabitsController < ApplicationController
  def index
    all_habits = Habit.all
    if all_habits.length > 0
      render json: HabitSerializer.serialized_json(all_habits), status: :ok
    else
      render json: { error: "Habits not found" }, status: :not_found
    end
  end
end