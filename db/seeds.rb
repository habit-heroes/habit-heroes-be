grant = User.create!(first_name: "Grant", last_name: "Davis", email: "grantdavis303@gmail.com", password_digest: "dummy123")

habit_1 = Habit.create!(name: "Brush Teeth", category: "Dental")
habit_2 = Habit.create!(name: "Floss Teeth", category: "Dental")
habit_3 = Habit.create!(name: "Run", category: "Exercise")

UserHabit.create!(
  user_id: grant.id,
  habit_id: habit_1.id,
  status: 'active',
  frequency_int: 2,
  frequency_type: 'day',
  started_date: '7/8/2024',
  times_completed: 0,
  days_completed: 0,
  weeks_completed: 0
)

UserHabit.create!(
  user_id: grant.id,
  habit_id: habit_2.id,
  status: 'active',
  frequency_int: 2,
  frequency_type: 'day',
  started_date: '7/8/2024',
  times_completed: 0,
  days_completed: 0,
  weeks_completed: 0
)

UserHabit.create!(
  user_id: grant.id,
  habit_id: habit_2.id,
  status: 'active',
  frequency_int: 3,
  frequency_type: 'week',
  started_date: '7/8/2024',
  times_completed: 0,
  days_completed: 0,
  weeks_completed: 0
)