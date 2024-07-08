Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      get "/users/:id", to: "users#show"
      get "/users/:id/habits", to: "user_habits#index"

    end
  end
end