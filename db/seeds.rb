5.times do
  @user = User.create!(
                       email: Faker::Internet.email,
                       password: 'password1',
                       password_confirmation: 'password1',
                       first_name: Faker::Name.first_name,
                       last_name: Faker::Name.last_name,
                       display_name: Faker::Internet.user_name
                       )
end

5.times do
  @colony = Colony.create!(
                           name: Faker::Team.name,
                           street_address: Faker::Address.street_address,
                           city: Faker::Address.city,
                           state: Faker::Address.state,
                           enviroment: Faker::Lorem.word,
                           zip_code: Faker::Address.zip,
                           pop: Faker::Number.number(2),
                           vet: Faker::Name.name
                          )
end
