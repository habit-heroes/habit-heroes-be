require 'rails_helper'

RSpec.describe Habit, type: :model do
  it { should have_many(:user_habits) }
  it { should have_many(:users).through(:user_habits) }
end