require 'rails_helper'

RSpec.describe UserHabit, type: :model do
  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:habit) }
  end
end