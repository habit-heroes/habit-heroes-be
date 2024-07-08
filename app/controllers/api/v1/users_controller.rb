class Api::V1::UsersController < ApplicationController
  def show
    user = User.find_by(id: params[:id])
    if !user.nil?
      render json: UserSerializer.new(user), status: 200
    else
      render json: { error: "User not found" }, status: 404
    end
  end
end