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
end