# Migrations Ran

# List migrations here
rails generate model User first_name last_name email password_digest
rails generate model Habit name category:integer
rails generate model UserHabit user:references habit:references status:integer goal_int:integer goal_type:integer started_date times_completed:integer days_completed:integer weeks_completed:integer

rails db:migrate