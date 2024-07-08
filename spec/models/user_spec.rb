require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many(:user_habits) }
    it { should have_many(:habits).through(:user_habits) }
  end
end