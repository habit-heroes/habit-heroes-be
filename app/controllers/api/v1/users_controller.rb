class Api::V1::UsersController < ApplicationController
  def show
    user = User.find_by(id: params[:id])
    if !user.nil?
      render json: UserSerializer.new.serialized_json(user)
    else
      render json: { error: "User not found" }
    end
  end
end