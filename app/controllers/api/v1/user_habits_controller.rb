class Api::V1::UserHabitsController < ApplicationController
  def index
    user = User.find_by(id: params[:id])
    if !user.nil?
      if !user.user_habits.empty?
        render json: UserHabitSerializer.serialized_json(user), status: :ok
      else
        render json: { data: [] }, status: :ok
      end
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
end