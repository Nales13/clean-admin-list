# name: clean-admin-list
# version: 1.0.1
# authors: buildthomas

after_initialize do

  add_to_serializer(:about, :admins) do
    admin_list_filter_suffix = SiteSetting.admin_list_filter_suffix
    
    # hide emails that do not match setting value (will do nothing if setting == '')
    object.admins.select { |u| u.email.match(/#{Regexp.escape(admin_list_filter_suffix)}/i) }
  end
  
  letters_shown = 1;
  
  add_to_serializer(:user, :email) do
    idx = email.index('@');
    if (idx)
      prefix = email[0, idx];
      prefix[0, letters_shown] + ('*' * (idx < letters_shown ? 0 : idx - letters_shown)) + email[idx, email.length]
    else
      ('*') * email.length
    end
  end

end
