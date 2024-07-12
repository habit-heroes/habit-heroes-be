require 'rails_helper'

RSpec.describe 'User Habit Requests' do
  describe 'End Point 2' do
    it "successfully returns all of a user's user_habits" do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)
      habit_2 = Habit.create!(name: "Floss Teeth", category: 0)

      uh_1 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_1.id,
        status: 'active',
        goal_int: 2,
        goal_type: 'day',
        started_date: '7/8/2024',
        times_completed: 0,
        days_completed: 0,
        weeks_completed: 0
      )

      uh_2 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_2.id,
        status: 'active',
        goal_int: 2,
        goal_type: 'day',
        started_date: '7/8/2024',
        times_completed: 0,
        days_completed: 0,
        weeks_completed: 0
      )

      get "/api/v1/users/#{grant.id}/habits"

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)

      expect(parsed_json[:data]).to be_a (Array)
      expect(parsed_json[:data].first).to be_a (Hash)

      expect(parsed_json[:data].first).to have_key (:id)
      expect(parsed_json[:data].first).to have_key (:name)
      expect(parsed_json[:data].first).to have_key (:status)
      expect(parsed_json[:data].first).to have_key (:goal_int)
      expect(parsed_json[:data].first).to have_key (:goal_type)
      expect(parsed_json[:data].first).to have_key (:started_date)
      expect(parsed_json[:data].first).to have_key (:times_completed)
      expect(parsed_json[:data].first).to have_key (:days_completed)
      expect(parsed_json[:data].first).to have_key (:weeks_completed)

      expect(parsed_json[:data].first[:id]).to eq (uh_1.id)
      expect(parsed_json[:data].first[:name]).to eq (habit_1.name)
      expect(parsed_json[:data].first[:status]).to eq (uh_1.status)
      expect(parsed_json[:data].first[:goal_int]).to eq (uh_1.goal_int)
      expect(parsed_json[:data].first[:goal_type]).to eq (uh_1.goal_type)
      expect(parsed_json[:data].first[:started_date]).to eq (uh_1.started_date)
      expect(parsed_json[:data].first[:times_completed]).to eq (uh_1.times_completed)
      expect(parsed_json[:data].first[:days_completed]).to eq (uh_1.days_completed)
      expect(parsed_json[:data].first[:weeks_completed]).to eq (uh_1.weeks_completed)
    end

    it "returns an empty array if the user has no user_habits" do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")

      get "/api/v1/users/#{grant.id}/habits"

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)

      expect(parsed_json[:data]).to be_a (Array)
      expect(parsed_json[:data].empty?).to eq (true)
    end

    it 'returns an error message if no user is found' do
      get '/api/v1/users/1/habits'

      expect(response).to_not be_successful
      expect(response.status).to eq (404)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:error)

      expect(parsed_json[:error]).to be_a (String)
      expect(parsed_json[:error]).to eq ('User not found')
    end
  end

  describe 'End Point 5' do
    it 'successfully creates a new user_habit w/ 1x per day' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit = Habit.create!(name: "Sleep 8 Hours", category: 1)

      post "/api/v1/users/#{grant.id}/habits", params:
      {
        "user_id": grant.id,
        "habit_id": habit.id
      }

      expect(response).to be_successful
      expect(response.status).to eq (201)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)
  
      expect(parsed_json[:data]).to be_a (Hash)
      expect(parsed_json[:data]).to have_key (:id)
      expect(parsed_json[:data]).to have_key (:name)
      expect(parsed_json[:data]).to have_key (:status)
      expect(parsed_json[:data]).to have_key (:goal_int)
      expect(parsed_json[:data]).to have_key (:goal_type)
      expect(parsed_json[:data]).to have_key (:started_date)
      expect(parsed_json[:data]).to have_key (:times_completed)
      expect(parsed_json[:data]).to have_key (:days_completed)
      expect(parsed_json[:data]).to have_key (:weeks_completed)

      expect(parsed_json[:data][:id]).to be_a (Integer)
      expect(parsed_json[:data][:name]).to be_a (String)
      expect(parsed_json[:data][:status]).to be_a (String)
      expect(parsed_json[:data][:goal_int]).to be_a (Integer)
      expect(parsed_json[:data][:goal_type]).to be_a (String)
      expect(parsed_json[:data][:started_date]).to be_a (String)
      expect(parsed_json[:data][:times_completed]).to be_a (Integer)
      expect(parsed_json[:data][:days_completed]).to be_a (Integer)
      expect(parsed_json[:data][:weeks_completed]).to be_a (Integer)

      # expect(parsed_json[:data][:id]).to eq (Integer)
      expect(parsed_json[:data][:name]).to eq ('Sleep 8 Hours')
      expect(parsed_json[:data][:status]).to eq ('active')
      expect(parsed_json[:data][:goal_int]).to eq (1)
      expect(parsed_json[:data][:goal_type]).to eq ('day')
      # expect(parsed_json[:data][:started_date]).to eq (String)
      expect(parsed_json[:data][:times_completed]).to eq (0)
      expect(parsed_json[:data][:days_completed]).to eq (0)
      expect(parsed_json[:data][:weeks_completed]).to eq (0)
    end

    it 'successfully creates a new user_habit w/ 2x per day' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit = Habit.create!(name: "Brush Teeth", category: 0)

      post "/api/v1/users/#{grant.id}/habits", params:
      {
        "user_id": grant.id,
        "habit_id": habit.id
      }

      expect(response).to be_successful
      expect(response.status).to eq (201)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)
  
      expect(parsed_json[:data]).to be_a (Hash)
      expect(parsed_json[:data]).to have_key (:id)
      expect(parsed_json[:data]).to have_key (:name)
      expect(parsed_json[:data]).to have_key (:status)
      expect(parsed_json[:data]).to have_key (:goal_int)
      expect(parsed_json[:data]).to have_key (:goal_type)
      expect(parsed_json[:data]).to have_key (:started_date)
      expect(parsed_json[:data]).to have_key (:times_completed)
      expect(parsed_json[:data]).to have_key (:days_completed)
      expect(parsed_json[:data]).to have_key (:weeks_completed)

      expect(parsed_json[:data][:id]).to be_a (Integer)
      expect(parsed_json[:data][:name]).to be_a (String)
      expect(parsed_json[:data][:status]).to be_a (String)
      expect(parsed_json[:data][:goal_int]).to be_a (Integer)
      expect(parsed_json[:data][:goal_type]).to be_a (String)
      expect(parsed_json[:data][:started_date]).to be_a (String)
      expect(parsed_json[:data][:times_completed]).to be_a (Integer)
      expect(parsed_json[:data][:days_completed]).to be_a (Integer)
      expect(parsed_json[:data][:weeks_completed]).to be_a (Integer)

      # expect(parsed_json[:data][:id]).to eq (Integer)
      expect(parsed_json[:data][:name]).to eq ('Brush Teeth')
      expect(parsed_json[:data][:status]).to eq ('active')
      expect(parsed_json[:data][:goal_int]).to eq (2)
      expect(parsed_json[:data][:goal_type]).to eq ('day')
      # expect(parsed_json[:data][:started_date]).to eq (String)
      expect(parsed_json[:data][:times_completed]).to eq (0)
      expect(parsed_json[:data][:days_completed]).to eq (0)
      expect(parsed_json[:data][:weeks_completed]).to eq (0)
    end

    it 'successfully creates a new user_habit w/ week' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit = Habit.create!(name: "Lift Weights", category: 5)

      post "/api/v1/users/#{grant.id}/habits", params:
      {
        "user_id": grant.id,
        "habit_id": habit.id
      }

      expect(response).to be_successful
      expect(response.status).to eq (201)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)
  
      expect(parsed_json[:data]).to be_a (Hash)
      expect(parsed_json[:data]).to have_key (:id)
      expect(parsed_json[:data]).to have_key (:name)
      expect(parsed_json[:data]).to have_key (:status)
      expect(parsed_json[:data]).to have_key (:goal_int)
      expect(parsed_json[:data]).to have_key (:goal_type)
      expect(parsed_json[:data]).to have_key (:started_date)
      expect(parsed_json[:data]).to have_key (:times_completed)
      expect(parsed_json[:data]).to have_key (:days_completed)
      expect(parsed_json[:data]).to have_key (:weeks_completed)

      expect(parsed_json[:data][:id]).to be_a (Integer)
      expect(parsed_json[:data][:name]).to be_a (String)
      expect(parsed_json[:data][:status]).to be_a (String)
      expect(parsed_json[:data][:goal_int]).to be_a (Integer)
      expect(parsed_json[:data][:goal_type]).to be_a (String)
      expect(parsed_json[:data][:started_date]).to be_a (String)
      expect(parsed_json[:data][:times_completed]).to be_a (Integer)
      expect(parsed_json[:data][:days_completed]).to be_a (Integer)
      expect(parsed_json[:data][:weeks_completed]).to be_a (Integer)

      # expect(parsed_json[:data][:id]).to eq (Integer)
      expect(parsed_json[:data][:name]).to eq ('Lift Weights')
      expect(parsed_json[:data][:status]).to eq ('active')
      expect(parsed_json[:data][:goal_int]).to eq (3)
      expect(parsed_json[:data][:goal_type]).to eq ('week')
      # expect(parsed_json[:data][:started_date]).to eq (String)
      expect(parsed_json[:data][:times_completed]).to eq (0)
      expect(parsed_json[:data][:days_completed]).to eq (0)
      expect(parsed_json[:data][:weeks_completed]).to eq (0)
    end

    it 'returns an appropriate error when a user_habit already exists' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit = Habit.create!(name: "Brush Teeth", category: 0)

      UserHabit.create!(
        user_id: grant.id,
        habit_id: habit.id,
        status: 1,
        goal_int: 2,
        goal_type: 0,
        started_date: Time.now,
        times_completed: 0,
        days_completed: 10,
        weeks_completed: 0
      )

      post "/api/v1/users/#{grant.id}/habits", params:
      {
        "user_id": grant.id,
        "habit_id": habit.id
      }

      expect(response).to_not be_successful
      expect(response.status).to eq (409)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:error)

      expect(parsed_json[:error]).to be_a (String)
      expect(parsed_json[:error]).to eq ('UserHabit already exists')
    end

    it 'returns an appropriate error when no habit exists' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")

      post "/api/v1/users/#{grant.id}/habits", params:
      {
        "user_id": grant.id
      }

      expect(response).to_not be_successful
      expect(response.status).to eq (404)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:error)
  
      expect(parsed_json[:error]).to be_a (String)
      expect(parsed_json[:error]).to eq ('Habit not found')
    end

    it 'returns an appropriate error when no habit exists' do
      habit = Habit.create!(name: "Brush Teeth", category: 0)

      post "/api/v1/users/123123/habits", params:
      {
        "habit_id": habit.id
      }

      expect(response).to_not be_successful
      expect(response.status).to eq (404)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:error)
  
      expect(parsed_json[:error]).to be_a (String)
      expect(parsed_json[:error]).to eq ('User not found')
    end
  end

  describe 'End Point 6' do
    it 'successfully updates a user_habit w/ times_completed' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)

      uh_1 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_1.id,
        status: 'active',
        goal_int: 2,
        goal_type: 'day',
        started_date: '7/8/2024',
        times_completed: 0,
        days_completed: 0,
        weeks_completed: 0
      )

      patch "/api/v1/users/#{grant.id}/habits", params: 
      {
        "user_habit_id": uh_1.id
      }

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)
  
      expect(parsed_json[:data]).to be_a (Hash)
      expect(parsed_json[:data]).to have_key (:id)
      expect(parsed_json[:data]).to have_key (:name)
      expect(parsed_json[:data]).to have_key (:status)
      expect(parsed_json[:data]).to have_key (:goal_int)
      expect(parsed_json[:data]).to have_key (:goal_type)
      expect(parsed_json[:data]).to have_key (:started_date)
      expect(parsed_json[:data]).to have_key (:times_completed)
      expect(parsed_json[:data]).to have_key (:days_completed)
      expect(parsed_json[:data]).to have_key (:weeks_completed)

      expect(parsed_json[:data][:id]).to be_a (Integer)
      expect(parsed_json[:data][:name]).to be_a (String)
      expect(parsed_json[:data][:status]).to be_a (String)
      expect(parsed_json[:data][:goal_int]).to be_a (Integer)
      expect(parsed_json[:data][:goal_type]).to be_a (String)
      expect(parsed_json[:data][:started_date]).to be_a (String)
      expect(parsed_json[:data][:times_completed]).to be_a (Integer)
      expect(parsed_json[:data][:days_completed]).to be_a (Integer)
      expect(parsed_json[:data][:weeks_completed]).to be_a (Integer)

      # expect(parsed_json[:data][:id]).to eq (Integer)
      expect(parsed_json[:data][:name]).to eq (habit_1.name)
      expect(parsed_json[:data][:status]).to eq (uh_1.status)
      expect(parsed_json[:data][:goal_int]).to eq (uh_1.goal_int)
      expect(parsed_json[:data][:goal_type]).to eq (uh_1.goal_type)
      # expect(parsed_json[:data][:started_date]).to eq (String)
      expect(parsed_json[:data][:times_completed]).to eq (uh_1.times_completed + 1)
      expect(parsed_json[:data][:days_completed]).to eq (uh_1.days_completed)
      expect(parsed_json[:data][:weeks_completed]).to eq (uh_1.weeks_completed)
    end

    it 'successfully updates a user_habit w/ days_completed' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)

      uh_1 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_1.id,
        status: 'active',
        goal_int: 2,
        goal_type: 'day',
        started_date: '7/8/2024',
        times_completed: 1,
        days_completed: 0,
        weeks_completed: 0
      )

      patch "/api/v1/users/#{grant.id}/habits", params: 
      {
        "user_habit_id": uh_1.id
      }

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)
  
      expect(parsed_json[:data]).to be_a (Hash)
      expect(parsed_json[:data]).to have_key (:id)
      expect(parsed_json[:data]).to have_key (:name)
      expect(parsed_json[:data]).to have_key (:status)
      expect(parsed_json[:data]).to have_key (:goal_int)
      expect(parsed_json[:data]).to have_key (:goal_type)
      expect(parsed_json[:data]).to have_key (:started_date)
      expect(parsed_json[:data]).to have_key (:times_completed)
      expect(parsed_json[:data]).to have_key (:days_completed)
      expect(parsed_json[:data]).to have_key (:weeks_completed)

      expect(parsed_json[:data][:id]).to be_a (Integer)
      expect(parsed_json[:data][:name]).to be_a (String)
      expect(parsed_json[:data][:status]).to be_a (String)
      expect(parsed_json[:data][:goal_int]).to be_a (Integer)
      expect(parsed_json[:data][:goal_type]).to be_a (String)
      expect(parsed_json[:data][:started_date]).to be_a (String)
      expect(parsed_json[:data][:times_completed]).to be_a (Integer)
      expect(parsed_json[:data][:days_completed]).to be_a (Integer)
      expect(parsed_json[:data][:weeks_completed]).to be_a (Integer)

      # expect(parsed_json[:data][:id]).to eq (Integer)
      expect(parsed_json[:data][:name]).to eq (habit_1.name)
      expect(parsed_json[:data][:status]).to eq (uh_1.status)
      expect(parsed_json[:data][:goal_int]).to eq (uh_1.goal_int)
      expect(parsed_json[:data][:goal_type]).to eq (uh_1.goal_type)
      # expect(parsed_json[:data][:started_date]).to eq (String)
      expect(parsed_json[:data][:times_completed]).to eq (0)
      expect(parsed_json[:data][:days_completed]).to eq (1)
      expect(parsed_json[:data][:weeks_completed]).to eq (uh_1.weeks_completed)
    end

    it 'successfully updates a user_habit w/ days_completed (light streak)' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)
      uh_1 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_1.id,
        status: 'active',
        goal_int: 2,
        goal_type: 'day',
        started_date: '7/8/2024',
        times_completed: 1,
        days_completed: 2,
        weeks_completed: 0
      )

      patch "/api/v1/users/#{grant.id}/habits", params: 
      {
        "user_habit_id": uh_1.id
      }

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)
  
      expect(parsed_json[:data]).to be_a (Hash)
      expect(parsed_json[:data]).to have_key (:id)
      expect(parsed_json[:data]).to have_key (:name)
      expect(parsed_json[:data]).to have_key (:status)
      expect(parsed_json[:data]).to have_key (:goal_int)
      expect(parsed_json[:data]).to have_key (:goal_type)
      expect(parsed_json[:data]).to have_key (:started_date)
      expect(parsed_json[:data]).to have_key (:times_completed)
      expect(parsed_json[:data]).to have_key (:days_completed)
      expect(parsed_json[:data]).to have_key (:weeks_completed)

      expect(parsed_json[:data][:id]).to be_a (Integer)
      expect(parsed_json[:data][:name]).to be_a (String)
      expect(parsed_json[:data][:status]).to be_a (String)
      expect(parsed_json[:data][:goal_int]).to be_a (Integer)
      expect(parsed_json[:data][:goal_type]).to be_a (String)
      expect(parsed_json[:data][:started_date]).to be_a (String)
      expect(parsed_json[:data][:times_completed]).to be_a (Integer)
      expect(parsed_json[:data][:days_completed]).to be_a (Integer)
      expect(parsed_json[:data][:weeks_completed]).to be_a (Integer)

      # expect(parsed_json[:data][:id]).to eq (Integer)
      expect(parsed_json[:data][:name]).to eq (habit_1.name)
      expect(parsed_json[:data][:status]).to eq (uh_1.status)
      expect(parsed_json[:data][:goal_int]).to eq (uh_1.goal_int)
      expect(parsed_json[:data][:goal_type]).to eq (uh_1.goal_type)
      # expect(parsed_json[:data][:started_date]).to eq (String)
      expect(parsed_json[:data][:times_completed]).to eq (0)
      expect(parsed_json[:data][:days_completed]).to eq (3)
      expect(parsed_json[:data][:weeks_completed]).to eq (uh_1.weeks_completed)

      expect(Streak.count).to eq (1)
      expect(uh_1.streak.streak_type).to eq ('light')
    end

    it 'successfully updates a user_habit w/ weeks_completed' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)

      uh_1 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_1.id,
        status: 'active',
        goal_int: 3,
        goal_type: 'week',
        started_date: '7/8/2024',
        times_completed: 2,
        days_completed: 0,
        weeks_completed: 0
      )

      patch "/api/v1/users/#{grant.id}/habits", params: 
      {
        "user_habit_id": uh_1.id
      }

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)
  
      expect(parsed_json[:data]).to be_a (Hash)
      expect(parsed_json[:data]).to have_key (:id)
      expect(parsed_json[:data]).to have_key (:name)
      expect(parsed_json[:data]).to have_key (:status)
      expect(parsed_json[:data]).to have_key (:goal_int)
      expect(parsed_json[:data]).to have_key (:goal_type)
      expect(parsed_json[:data]).to have_key (:started_date)
      expect(parsed_json[:data]).to have_key (:times_completed)
      expect(parsed_json[:data]).to have_key (:days_completed)
      expect(parsed_json[:data]).to have_key (:weeks_completed)

      expect(parsed_json[:data][:id]).to be_a (Integer)
      expect(parsed_json[:data][:name]).to be_a (String)
      expect(parsed_json[:data][:status]).to be_a (String)
      expect(parsed_json[:data][:goal_int]).to be_a (Integer)
      expect(parsed_json[:data][:goal_type]).to be_a (String)
      expect(parsed_json[:data][:started_date]).to be_a (String)
      expect(parsed_json[:data][:times_completed]).to be_a (Integer)
      expect(parsed_json[:data][:days_completed]).to be_a (Integer)
      expect(parsed_json[:data][:weeks_completed]).to be_a (Integer)

      # expect(parsed_json[:data][:id]).to eq (Integer)
      expect(parsed_json[:data][:name]).to eq (habit_1.name)
      expect(parsed_json[:data][:status]).to eq (uh_1.status)
      expect(parsed_json[:data][:goal_int]).to eq (uh_1.goal_int)
      expect(parsed_json[:data][:goal_type]).to eq (uh_1.goal_type)
      # expect(parsed_json[:data][:started_date]).to eq (String)
      expect(parsed_json[:data][:times_completed]).to eq (0)
      expect(parsed_json[:data][:days_completed]).to eq (uh_1.days_completed)
      expect(parsed_json[:data][:weeks_completed]).to eq (1)
    end

    it 'successfully updates a user_habit w/ weeks_completed (fire streak)' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)
      uh_1 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_1.id,
        status: 'active',
        goal_int: 3,
        goal_type: 'week',
        started_date: '7/8/2024',
        times_completed: 2,
        days_completed: 0,
        weeks_completed: 9
      )
      Streak.create!(
        user_habit_id: uh_1.id,
        streak_type: 0
      )

      patch "/api/v1/users/#{grant.id}/habits", params: 
      {
        "user_habit_id": uh_1.id
      }

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)
  
      expect(parsed_json[:data]).to be_a (Hash)
      expect(parsed_json[:data]).to have_key (:id)
      expect(parsed_json[:data]).to have_key (:name)
      expect(parsed_json[:data]).to have_key (:status)
      expect(parsed_json[:data]).to have_key (:goal_int)
      expect(parsed_json[:data]).to have_key (:goal_type)
      expect(parsed_json[:data]).to have_key (:started_date)
      expect(parsed_json[:data]).to have_key (:times_completed)
      expect(parsed_json[:data]).to have_key (:days_completed)
      expect(parsed_json[:data]).to have_key (:weeks_completed)

      expect(parsed_json[:data][:id]).to be_a (Integer)
      expect(parsed_json[:data][:name]).to be_a (String)
      expect(parsed_json[:data][:status]).to be_a (String)
      expect(parsed_json[:data][:goal_int]).to be_a (Integer)
      expect(parsed_json[:data][:goal_type]).to be_a (String)
      expect(parsed_json[:data][:started_date]).to be_a (String)
      expect(parsed_json[:data][:times_completed]).to be_a (Integer)
      expect(parsed_json[:data][:days_completed]).to be_a (Integer)
      expect(parsed_json[:data][:weeks_completed]).to be_a (Integer)

      # expect(parsed_json[:data][:id]).to eq (Integer)
      expect(parsed_json[:data][:name]).to eq (habit_1.name)
      expect(parsed_json[:data][:status]).to eq (uh_1.status)
      expect(parsed_json[:data][:goal_int]).to eq (uh_1.goal_int)
      expect(parsed_json[:data][:goal_type]).to eq (uh_1.goal_type)
      # expect(parsed_json[:data][:started_date]).to eq (String)
      expect(parsed_json[:data][:times_completed]).to eq (0)
      expect(parsed_json[:data][:days_completed]).to eq (uh_1.days_completed)
      expect(parsed_json[:data][:weeks_completed]).to eq (10)

      expect(Streak.count).to eq (1)
      expect(uh_1.streak.streak_type).to eq ('fire')
    end

    it 'returns an appropriate error if the user_habit status is inactive' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)

      uh_1 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_1.id,
        status: 'inactive',
        goal_int: 2,
        goal_type: 'day',
        started_date: '7/8/2024',
        times_completed: 0,
        days_completed: 0,
        weeks_completed: 0
      )

      patch "/api/v1/users/#{grant.id}/habits", params: 
      {
        "user_habit_id": uh_1.id
      }

      expect(response).to_not be_successful
      expect(response.status).to eq (409)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:error)
  
      expect(parsed_json[:error]).to be_a (String)
      expect(parsed_json[:error]).to eq ('The status of this UserHabit is inactive')
    end

    it 'returns an appropriate error if the user_habit is not found' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)

      patch "/api/v1/users/#{grant.id}/habits", params: 
      {
        "user_habit_id": 1
      }

      expect(response).to_not be_successful
      expect(response.status).to eq (404)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:error)
  
      expect(parsed_json[:error]).to be_a (String)
      expect(parsed_json[:error]).to eq ('UserHabit not found')
    end
  end
end