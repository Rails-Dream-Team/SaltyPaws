# 5.times do
#   @organization = Organization.create!(name: Faker::Team.name)
#   5.times do
#     @user = User.create!(
#                         email: Faker::Internet.email,
#                         password: 'password1',
#                         password_confirmation: 'password1',
#                         first_name: Faker::Name.first_name,
#                         last_name: Faker::Name.last_name,
#                         display_name: Faker::Internet.user_name
#                         )
#     @organization.users.append(@user)
#   end
# end
#
# 5.times do
#   @colony = Colony.create!(
#                            name: Faker::Team.name,
#                            street_address: Faker::Address.street_address,
#                            city: Faker::Address.city,
#                            state: Faker::Address.state,
#                            enviroment: Faker::Lorem.word,
#                            zip_code: Faker::Address.zip,
#                            pop: Faker::Number.number(2),
#                            vet: Faker::Name.name
#                           )
# end

@board = Board.create!(title: 'Test Board')
@topic = @board.topics.create!(title: 'Test Topic 1', user_id: 1)
5.times do
  @topic.posts.create!(
    content: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    user_id: 1
  )
end
