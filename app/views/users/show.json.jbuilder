json.array! @user.each do |info|
  json.first_name           info.first_name
  json.last_name            info.last_name
  json.created_at           info.created_at(:strftime, '%D %r')
  json.city                 info.city
  json.state                info.state
  json.age                  info.age
  json.pets                 info.volunteer_work
  json.about_me             info.about_me
end
