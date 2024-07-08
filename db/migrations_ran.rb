# Migrations Ran

# List migrations here
rails generate model User first_name last_name email password_digest
rails generate model Habit name category
rails generate model UserHabit user:references habit:references status frequency_int:integer frequency_type started_date times_completed:integer days_completed:integer weeks_completed:integer

rails db:migrate