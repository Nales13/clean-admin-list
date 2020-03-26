# Plugin: `clean-admin-list`

Filters the About page of the forum to only contain users that match a certain email domain.

---

## Features

- Filters the "Our Admins" and "Our Moderators" sections on the About page (at `%BASEURL%/about`) to only show users that have an email with a certain domain.

---

## Impact

### Community

It is easier for community members to see who they could contact about the forum, and who administrates / moderates the forum.

On the Roblox Developer Forum, without this plugin enabled, the list will also show accounts of the maintainers of the deployment of the forum, i.e. SoftServe Inc. staff. These users should not be contacted by community members because they will not be able to help with any of their issues, as they are not Roblox staff. The plugin helps reduce noise by filtering these accounts out of the result.

### Internal

Roblox staff have an easier overview of who has administration and moderation permissions on the forum within the company.

However, the full list of moderators and admins can now only be viewed by forum admins, via `%BASEURL%/admin/users/list/staff`.

### Resources

Adds a highly negligible processing cost whenever the About page is loaded by a user.

### Maintenance

Forum staff should ensure that users that should appear on the About page have an address of the right email domain listed on their account.

---

## Technical Scope

The filter is applied to the primary email address field of each staff user, and it only keeps users in the list of whom the primary email matches a certain domain that can be configured via plugin settings.

This is done by adding a custom serializer to the About page that acts on the :admins and :moderators fields. Since these fields are always serialized anyway, and no new data is added to the result (only filtered out), there is no security or privacy risk. Staff members control which staff accounts show up here by ensuring that their primary email addresses are set to the right domain.

---

## Configuration

The setting `clean_admin_list_suffix` should be set to the domain of which users should be shown on the About page only, i.e. `@domain.com`.
