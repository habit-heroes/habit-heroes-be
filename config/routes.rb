Rails.application.routes.draw do
  root "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do

      get '/users/:id', to: 'users#show'
      get '/users/:id/habits', to: 'user_habits#index'
      post '/users/:id/habits', to: 'user_habits#create'
      patch '/users/:id/habits', to: 'user_habits#update'
      get '/users/:id/streaks', to: 'user_streaks#index'
      get '/habits', to: 'habits#index'

    end
  end
end