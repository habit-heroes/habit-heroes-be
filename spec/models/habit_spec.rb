require 'rails_helper'

RSpec.describe Habit, type: :model do
  describe 'relationships' do
    it { should have_many(:user_habits) }
    it { should have_many(:users).through(:user_habits) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
  end

  describe 'enums' do
    it { should define_enum_for(:category).with_values([:dental, :sleep, :productivity, :hydration, :hobby, :exercise]) }
  end

  describe 'helper methods' do
    it '#week_type' do
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)
      habit_10 = Habit.create!(name: "Lift Weights", category: 5)
      expect(habit_1.week_type).to eq (0)
      expect(habit_10.week_type).to eq (1)
    end

    it '#determine_frequency' do
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)
      habit_5 = Habit.create!(name: "Wake Up at 7am", category: 2)
      habit_10 = Habit.create!(name: "Lift Weights", category: 5)
      expect(habit_1.determine_frequency).to eq (2)
      expect(habit_5.determine_frequency).to eq (1)
      expect(habit_10.determine_frequency).to eq (3)
    end
  end
end