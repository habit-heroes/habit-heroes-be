require 'rails_helper'

RSpec.describe UserHabit, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:habit) }
    it { should have_one(:streak) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:habit_id) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:goal_int) }
    it { should validate_presence_of(:goal_type) }
    it { should validate_presence_of(:started_date) }
    it { should validate_presence_of(:times_completed) }
    it { should validate_presence_of(:days_completed) }
    it { should validate_presence_of(:weeks_completed) }
    it { should validate_numericality_of(:user_id) }
    it { should validate_numericality_of(:habit_id) }
    it { should validate_numericality_of(:goal_int) }
    it { should validate_numericality_of(:times_completed) }
    it { should validate_numericality_of(:days_completed) }
    it { should validate_numericality_of(:weeks_completed) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values([:inactive, :active]) }
    it { should define_enum_for(:goal_type).with_values([:day, :week]) }
  end

  describe 'helper methods' do
    it '#update_user_habit' do
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
        weeks_completed: 0
      )
      uh_10 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_10.id,
        status: 1,
        goal_int: 3,
        goal_type: 1,
        started_date: Time.now,
        times_completed: 0,
        days_completed: 0,
        weeks_completed: 0
      )
      expect(uh_1.days_completed).to eq (0)
      expect(uh_1.update_user_habit).to eq (true)
      expect(uh_1.days_completed).to eq (1)
      expect(uh_10.weeks_completed).to eq (0)
      expect(uh_10.update_user_habit).to eq (true)
      expect(uh_10.weeks_completed).to eq (1)
    end

    it '#check_user_habit_streak' do
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
        days_completed: 3,
        weeks_completed: 0
      )
      uh_10 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_10.id,
        status: 1,
        goal_int: 3,
        goal_type: 1,
        started_date: Time.now,
        times_completed: 0,
        days_completed: 0,
        weeks_completed: 10
      )
      streak_10 = Streak.create!(
        user_habit_id: uh_10.id,
        streak_type: 0
      )
      expect(Streak.count).to eq (1)
      expect(uh_1.check_user_habit_streak).to be_a (Streak)
      expect(Streak.count).to eq (2)
      expect(uh_10.streak.streak_type).to eq ('light')
      expect(uh_10.check_user_habit_streak).to eq (true)
      expect(uh_10.streak.streak_type).to eq ('fire')
    end

    it '#light_streak_eligible?' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grant@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)
      habit_2 = Habit.create!(name: "Floss Teeth", category: 0)
      uh_1 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_1.id,
        status: 1,
        goal_int: 2,
        goal_type: 0,
        started_date: Time.now,
        times_completed: 0,
        days_completed: 0,
        weeks_completed: 0
      )
      uh_2 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_2.id,
        status: 1,
        goal_int: 2,
        goal_type: 0,
        started_date: Time.now,
        times_completed: 0,
        days_completed: 3,
        weeks_completed: 0
      )
      expect(uh_1.light_streak_eligible?).to eq (false)
      expect(uh_2.light_streak_eligible?).to eq (true)
    end

    it '#fire_streak_eligible?' do
      grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grant@gmail.com", password_digest: "dummy123")
      habit_1 = Habit.create!(name: "Brush Teeth", category: 0)
      habit_2 = Habit.create!(name: "Floss Teeth", category: 0)
      uh_1 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_1.id,
        status: 1,
        goal_int: 2,
        goal_type: 0,
        started_date: Time.now,
        times_completed: 0,
        days_completed: 5,
        weeks_completed: 0
      )
      uh_2 = UserHabit.create!(
        user_id: grant.id,
        habit_id: habit_2.id,
        status: 1,
        goal_int: 2,
        goal_type: 0,
        started_date: Time.now,
        times_completed: 0,
        days_completed: 10,
        weeks_completed: 0
      )
      expect(uh_1.fire_streak_eligible?).to eq (false)
      expect(uh_2.fire_streak_eligible?).to eq (true)
    end
  end
end