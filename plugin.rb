# name: clean-admin-list
# version: 1.0.0
# authors: buildthomas

enabled_site_setting :clean_admin_list_enabled

after_initialize do

  module CleanAdminList
    def self.filter_staff(users)
      return users unless SiteSetting.clean_admin_list_enabled
      
      # hide emails that do not match setting value (will do nothing if setting == '')
      users.select { |u|
        u.email.match(/#{Regexp.escape(SiteSetting.clean_admin_list_suffix)}/i)
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
