grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grant@gmail.com", password_digest: "dummy123")
brandon = User.create!(first_name: "Brandon", last_name: "Doza", email: "brandon@gmail.com", password_digest: "dummy123")
laurel = User.create!(first_name: "Laurel", last_name: "Bonal", email: "laurel@gmail.com", password_digest: "dummy123")

habit_1 = Habit.create!(name: "Brush Teeth", category: 0)
habit_2 = Habit.create!(name: "Floss Teeth", category: 0)
habit_3 = Habit.create!(name: "Rinse w/ Mouth Wash", category: 0)
habit_4 = Habit.create!(name: "Sleep 8 Hours", category: 1)
habit_5 = Habit.create!(name: "Wake Up at 7am", category: 2)
habit_6 = Habit.create!(name: "Drink 100oz of Water", category: 3)
habit_7 = Habit.create!(name: "Read", category: 4)
habit_8 = Habit.create!(name: "Write", category: 4)
habit_9 = Habit.create!(name: "Walk 10,000 Steps", category: 5)
habit_10 = Habit.create!(name: "Lift Weights", category: 5)

uh_1 = UserHabit.create!(
  user_id: grant.id,
  habit_id: habit_1.id,
  status: 1,
  goal_int: 2,
  goal_type: 0,
  started_date: Time.now,
  times_completed: 0,
  days_completed: 10,
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

uh_3 = UserHabit.create!(
  user_id: grant.id,
  habit_id: habit_10.id,
  status: 1,
  goal_int: 3,
  goal_type: 1,
  started_date: Time.now,
  times_completed: 0,
  days_completed: 0,
  weeks_completed: 2
)

streak_1 = Streak.create!(
  user_habit_id: uh_1.id,
  streak_type: 1
)

streak_2 = Streak.create!(
  user_habit_id: uh_2.id,
  streak_type: 1
)

puts "Seeded Successfully"