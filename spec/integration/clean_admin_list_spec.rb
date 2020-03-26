require "rails_helper"

RSpec.describe "clean-admin-list" do
    
    def get_about_staff_ids(suffix = "")
        SiteSetting.clean_admin_list_suffix = suffix

        get "/about.json"
        expect(response.status).to eq(200)
        
        body = ::JSON.parse(response.body)

        admins = body["about"]["admins"] || []
        moderators = body["about"]["moderators"] || []

        return admins.map { |user| user["id"] }, moderators.map { |user| user["id"] }
    end

    before do
        Fabricate(:admin).email = "a@show.com"
        Fabricate(:admin).email = "b@hide.com"
        Fabricate(:moderator).email = "c@show.com"
        Fabricate(:moderator).email = "d@hide.com"
    end

    it "should only show staff users that match suffix" do
        admins_about, moderators_about = get_about_staff_ids("@show.com")

        admins = About.new.admins
            .select { |user| user.email.end_with?("@show.com") }
            .map { |user| user.id }
        
        moderators = About.new.moderators
            .select { |user| user.email.end_with?("@show.com") }
            .map { |user| user.id }
        
        expect(admins.to_set == admins_about.to_set).to eq(true)
        expect(moderators.to_set == moderators_about.to_set).to eq(true)
    end

    it "should show all staff when suffix is empty" do
        admins_about, moderators_about = get_about_staff_ids

        admins = About.new.admins.map { |user| user.id }
        moderators = About.new.moderators.map { |user| user.id }

        expect(admins.to_set == admins_about.to_set).to eq(true)
        expect(moderators.to_set == moderators_about.to_set).to eq(true)
    end

end
