class User < ApplicationRecord
  has_many :user_habits
  has_many :habits, through: :user_habits

  validates_presence_of :first_name, :last_name, :email, :password_digest
  validates_uniqueness_of :email
end
