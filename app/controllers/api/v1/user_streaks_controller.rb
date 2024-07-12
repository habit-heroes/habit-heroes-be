class Api::V1::UserStreaksController < ApplicationController
  def index # Refactor
    user = User.find_by(id: params[:id])
    if !user.nil?
      if !user.streaks.empty?
        render json: UserStreakSerializer.serialized_json_user_list(user), status: :ok
      else
        render json: { data: [] }, status: :ok
      end
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
end