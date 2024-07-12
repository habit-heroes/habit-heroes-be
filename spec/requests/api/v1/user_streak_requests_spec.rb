require 'rails_helper'

RSpec.describe 'User Streak Requests' do
  describe 'End Point 3' do
    it "successfully returns all of a user's streaks" do
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
        days_completed: 4,
        weeks_completed: 0
      )

      streak = Streak.create!(
        user_habit_id: uh_1.id,
        streak_type: 0
      )

      get "/api/v1/users/#{grant.id}/streaks"

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)

      expect(parsed_json[:data]).to be_a (Array)
      expect(parsed_json[:data].first).to be_a (Hash)

      expect(parsed_json[:data].first).to have_key (:id)
      expect(parsed_json[:data].first).to have_key (:name)
      expect(parsed_json[:data].first).to have_key (:category)
      expect(parsed_json[:data].first).to have_key (:goal_type)
      expect(parsed_json[:data].first).to have_key (:streak_type)
      expect(parsed_json[:data].first).to have_key (:days_or_weeks_completed)

      expect(parsed_json[:data].first[:id]).to eq (streak.id)
      expect(parsed_json[:data].first[:name]).to eq (habit_1.name)
      expect(parsed_json[:data].first[:category]).to eq (habit_1.category)
      expect(parsed_json[:data].first[:goal_type]).to eq (uh_1.goal_type)
      expect(parsed_json[:data].first[:streak_type]).to eq (streak.streak_type)
      expect(parsed_json[:data].first[:days_or_weeks_completed]).to eq (uh_1.days_completed)
    end

    it "returns an empty array if the user has no streaks" do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")

      get "/api/v1/users/#{grant.id}/streaks"

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)

      expect(parsed_json[:data]).to be_a (Array)
      expect(parsed_json[:data].empty?).to eq (true)
    end

    it 'returns an error message if no user is found' do
      get '/api/v1/users/1/streaks'

      expect(response).to_not be_successful
      expect(response.status).to eq (404)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:error)

      expect(parsed_json[:error]).to be_a (String)
      expect(parsed_json[:error]).to eq ('User not found')
    end
  end
end