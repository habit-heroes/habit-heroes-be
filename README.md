# Habit Heroes BE

### [Live deployment](https://powerful-scrubland-99007-c4aa236ac7c5.herokuapp.com/)

### About

This is an API-only application.

### Setup

```
[Fork and clone this repository]

cd app_name

bundle install
rails db:{drop,create,migrate,seed}
rails s

[Open LocalHost:5000]
```

### Versions

- Ruby 3.2.2
- Rails 7.1.3.4

### Database Schema

![database_schema](public/schema.png)

### Exposed End Points

<details>
  <summary> End Point 1 - Retrieve a User </summary>

**Request**

```http
GET /api/v1/users/1
Content-Type: application/json
Accept: application/json
```

**Response & Response Code** `200`

```json
{
  "data": {
    "id": 1,
    "type": "user",
    "attributes": {
      "first_name": "Grant",
      "last_name": "Davis",
      "email": "grantdavis303@gmail.com"
    }
  }
}
```
</details>

<details>
  <summary> End Point 2 - Retrieve a User's UserHabits </summary>

**Request**

```http
GET /api/v1/users/1/habits
Content-Type: application/json
Accept: application/json
```

**Response & Response Code** `200`

```json
{
  "data": [
    {
      "id": 1,
      "name": "Brush Teeth",
      "status": "active",
      "goal_int": 2,
      "goal_type": "day",
      "started_date": "7/8/2024",
      "times_completed": 0,
      "days_completed": 0,
      "weeks_completed": 0
    },
    {
      "id": 2,
      "name": "Floss Teeth",
      "status": "active",
      "goal_int": 2,
      "goal_type": "day",
      "started_date": "7/8/2024",
      "times_completed": 0,
      "days_completed": 0,
      "weeks_completed": 0
    }
  ]
}
```
</details>

<details>
  <summary> ND - End Point 3 - Retrieve a User's Streaks </summary>

**Request**

```http
GET /api/v1/users/:id/streaks
Content-Type: application/json
Accept: application/json
```

**Response & Response Code** `200`

```json
```
</details>

<details>
  <summary> End Point 4 - Retrieve All Habits </summary>

**Request**

```http
GET /api/v1/habits
Content-Type: application/json
Accept: application/json
```

**Response & Response Code** `200`

```json
{
  "data": [
    {
      "id": 1,
      "name": "Brush Teeth",
      "category": "dental"
    },
    {
      "id": 2,
      "name": "Floss Teeth",
      "category": "dental"
    },
    {
      "id": 3,
      "name": "Rinse w/ Mouth Wash",
      "category": "dental"
    },
    {
      "id": 4,
      "name": "Sleep 8 Hours",
      "category": "sleep"
    }
  ]
}
```
</details>

<details>
  <summary> ND - End Point 5 - Create a New UserHabit (w/ Body) </summary>

**Request**

```http
POST /api/v1/users/:id/habits
Content-Type: application/json
Accept: application/json

Body

{
  "times_completed": 1
}
```

**Response & Response Code** `201`

```json
```
</details>

<details>
  <summary> ND - End Point 6 - Update a User's UserHabit (w/ Body) </summary>

**Request**

```http
POST /api/v1/users/:id/habits
Content-Type: application/json
Accept: application/json

Body 

{

}
```

**Response & Response Code** `200`

```json
```
</details>

### Tests

* 36 Total Tests (254 / 254 LOC (100.0%) covered)
* 7 Request Tests (188 / 188 LOC (100.0%) covered)
* 29 Model Tests (100 / 100 LOC (100.0%) covered)

**Testing Instructions**

```
rails db:{drop,create,migrate,seed}
bundle exec rspec spec
```

### Resources

No resources used for this project.

### Contributors

* Grant Davis | [GitHub](https://github.com/grantdavis303), [LinkedIn](https://www.linkedin.com/in/grantdavis303/)
* Mel Langhoff | [GitHub](https://github.com/mel-langhoff), [LinkedIn](https://www.linkedin.com/in/melissalanghoff/)