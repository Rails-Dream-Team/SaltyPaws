json.array! @user.each do |info|
  json.first_name           info.first_name
end
