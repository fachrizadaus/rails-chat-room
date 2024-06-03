User.create!([
  {email: "user-one@mail.com", username: "user-one", password: "password", password_confirmation: "password"},
  {email: "user-two@mail.com", username: "user-two", password: "password", password_confirmation: "password"},
  {email: "user-three@mail.com", username: "user-three", password: "password", password_confirmation: "password"},
])

p "Created #{User.count} users data"