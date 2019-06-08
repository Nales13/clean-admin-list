after_initialize do

  add_to_serializer(:about, :admins) do
    object.admins.reject { |u| u.email =~ /@softserveinc\.com/i }
  end

end
