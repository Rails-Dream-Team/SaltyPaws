5.times do
  @user = User.create!(
                       email: Faker::Internet.email,
                       password: 'password1',
                       password_confirmation: 'password1',
                       first_name: Faker::Name.first_name,
                       last_name: Faker::Name.last_name
                       )
end
