class Api::V1::UsersController < ApplicationController
  def show
    user = User.find_by(id: params[:id])
    if !user.nil?
      render json: UserSerializer.serialized_json(user), status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
end