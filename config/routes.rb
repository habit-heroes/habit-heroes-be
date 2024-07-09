Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do

      get '/users/:id', to: 'users#show'
      get '/users/:id/habits', to: 'user_habits#index'
      get '/habits', to: 'habits#index'

    end
  end
end