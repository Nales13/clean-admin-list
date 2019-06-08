# name: clean-admin-list
# version: 1.0.0
# authors: buildthomas

after_initialize do

  # hide ***@softserveinc.com users from admin list
  add_to_serializer(:about, :admins) do
    object.admins.reject { |u| u.email =~ /@softserveinc\.com/i }
  end

end
