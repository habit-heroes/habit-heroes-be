require 'rails_helper'

RSpec.describe 'User Habit Requests' do
  it "successfully returns all of a user's user_habits" do
    grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")
    habit_1 = Habit.create!(name: "Brush Teeth", category: "Dental")
    habit_2 = Habit.create!(name: "Floss Teeth", category: "Dental")

    uh_1 = UserHabit.create!(
      user_id: grant.id,
      habit_id: habit_1.id,
      status: 'active',
      frequency_int: 2,
      frequency_type: 'day',
      started_date: '7/8/2024',
      times_completed: 0,
      days_completed: 0,
      weeks_completed: 0
    )

    uh_2 = UserHabit.create!(
          user_id: grant.id,
          habit_id: habit_2.id,
          status: 'active',
          frequency_int: 2,
          frequency_type: 'day',
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
    expect(parsed_json[:data].first).to have_key (:frequency_int)
    expect(parsed_json[:data].first).to have_key (:frequency_type)
    expect(parsed_json[:data].first).to have_key (:started_date)
    expect(parsed_json[:data].first).to have_key (:times_completed)
    expect(parsed_json[:data].first).to have_key (:days_completed)
    expect(parsed_json[:data].first).to have_key (:weeks_completed)

    expect(parsed_json[:data].first[:id]).to eq (uh_1.id)
    expect(parsed_json[:data].first[:name]).to eq (habit_1.name)
    expect(parsed_json[:data].first[:status]).to eq (uh_1.status)
    expect(parsed_json[:data].first[:frequency_int]).to eq (uh_1.frequency_int)
    expect(parsed_json[:data].first[:frequency_type]).to eq (uh_1.frequency_type)
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