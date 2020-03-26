# name: clean-admin-list
# version: 1.0.0
# authors: buildthomas

after_initialize do

  module CleanAdminList
    def self.filter_staff(users)
      # hide emails that do not match suffix (will do nothing if setting == '')
      users.select { |u|
        u.email.end_with?(SiteSetting.clean_admin_list_suffix)
      }
    end
  end

  add_to_serializer(:about, :admins) do
    CleanAdminList.filter_staff(object.admins)
  end

  add_to_serializer(:about, :moderators) do
    CleanAdminList.filter_staff(object.moderators)
  end

end
