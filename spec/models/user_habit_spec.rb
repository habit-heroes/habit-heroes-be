require 'rails_helper'

RSpec.describe UserHabit, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:habit) }
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
    it { should validate_numericality_of(:goal_int) }
    it { should validate_numericality_of(:times_completed) }
    it { should validate_numericality_of(:days_completed) }
    it { should validate_numericality_of(:weeks_completed) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values([:inactive, :active]) }
    it { should define_enum_for(:goal_type).with_values([:day, :week]) }
  end
end