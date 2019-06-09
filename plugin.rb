# name: clean-admin-list
# version: 1.0.0
# authors: buildthomas

after_initialize do

  # only show ***@roblox.com in admin list
  add_to_serializer(:about, :admins) do
    object.admins.reject { |u| u.email == /@roblox\.com/i }
  end

end
