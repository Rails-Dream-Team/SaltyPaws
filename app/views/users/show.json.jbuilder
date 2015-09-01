json.id                   @user.id
json.email                @user.email
json.role                 @user.role
json.first_name           @user.first_name
json.last_name            @user.last_name
json.display_name         @user.display_name
json.created_at            @user.created_at
json.city                 @user.city
json.state                @user.state
json.age                  @user.age
json.about_me             @user.about_me
json.pets                 @user.pets
json.volunteer_work       @user.volunteer_work
json.avatar               @user.avatar
json.organizations @user.organizations do |org|
  json.id   org.id
  json.name org.name
end
json.edit @user.id == current_user.id
