require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:user_habits) }
    it { should have_many(:habits).through(:user_habits) }
    it { should have_many(:streaks).through(:user_habits) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_uniqueness_of(:email) }
  end
end