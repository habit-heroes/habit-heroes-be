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
end