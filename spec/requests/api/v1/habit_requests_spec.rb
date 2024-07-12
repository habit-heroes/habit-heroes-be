require 'rails_helper'

RSpec.describe 'Habit Requests' do
  describe 'End Point 4' do
    it 'successfully returns all habits' do
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)
      habit_2 = Habit.create!(name: "Floss Teeth", category: 0)
      habit_3 = Habit.create!(name: "Rinse w/ Mouth Wash", category: 0)
      habit_4 = Habit.create!(name: "Sleep 8 Hours", category: 1)
      length = Habit.all.length

      get '/api/v1/habits'

      expect(response).to be_successful
      expect(response.status).to eq (200)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:data)

      expect(parsed_json[:data]).to be_a (Array)
      expect(parsed_json[:data].length).to eq (length)
      expect(parsed_json[:data].first).to be_a (Hash)

      expect(parsed_json[:data].first).to have_key (:id)
      expect(parsed_json[:data].first).to have_key (:name)
      expect(parsed_json[:data].first).to have_key (:category)

      expect(parsed_json[:data].first[:id]).to eq (habit_1.id)
      expect(parsed_json[:data].first[:name]).to eq (habit_1.name)
      expect(parsed_json[:data].first[:category]).to eq (habit_1.category)
    end

    it 'returns an error message if there are no habits' do
      get '/api/v1/habits'

      expect(response).to_not be_successful
      expect(response.status).to eq (404)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to be_a (Hash)
      expect(parsed_json).to have_key (:error)

      expect(parsed_json[:error]).to be_a (String)
      expect(parsed_json[:error]).to eq ('Habits not found')
    end
  end
end