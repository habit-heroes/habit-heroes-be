require 'rails_helper'

RSpec.describe Streak, type: :model do
  describe 'relationships' do
    it { should belong_to(:user_habit) }
    it { should have_one(:user).through(:user_habit) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_habit_id) }
    it { should validate_presence_of(:streak_type) }
    it { should validate_numericality_of(:user_habit_id) }
  end

  describe 'enums' do
    it { should define_enum_for(:streak_type).with_values([:light, :fire]) }
  end

  describe 'helper methods' do
    it '#days_or_weeks_completed' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grant@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)
      habit_10 = Habit.create!(name: "Lift Weights", category: 5)
      uh_1 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_1.id,
        status: 1,
        goal_int: 2,
        goal_type: 0,
        started_date: Time.now,
        times_completed: 0,
        days_completed: 0,
        weeks_completed: 3
      )
      uh_10= UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_10.id,
        status: 1,
        goal_int: 3,
        goal_type: 1,
        started_date: Time.now,
        times_completed: 0,
        days_completed: 0,
        weeks_completed: 6
      )
      streak_1 = Streak.create!(
        user_habit_id: uh_1.id,
        streak_type: 0
      )
      streak_2 = Streak.create!(
        user_habit_id: uh_10.id,
        streak_type: 0
      )
      expect(streak_1.days_or_weeks_completed).to eq (3)
      expect(streak_2.days_or_weeks_completed).to eq (6)
    end
  end
end