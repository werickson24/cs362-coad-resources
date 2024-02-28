require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do
  before do
    @user = create(:user)
    @admin = create(:user, :admin)
  end

  it "can create an organization application from the home screen" do
    log_in_as(@user)
    visit root_path
    click_on 'Dashboard'
    click_on 'Create Application'
    choose 'organization_agreement_eight_true'
    fill_in 'organization_primary_name', with: 'primary name'
    fill_in 'organization_name', with: 'org name'
    fill_in 'organization_title', with: 'do tests'
    fill_in 'organization_phone', with: '555-444-3333'
    fill_in 'organization_secondary_name', with: 'secondary name'
    fill_in 'organization_secondary_phone', with: '333-222-1111'
    fill_in 'organization_email', with: 'org@email.com'
    fill_in 'organization_description', with: 'we do tests'
    choose 'organization_transportation_yes'
    click_on 'commit'
    expect(page.body).to have_text('Thank you for applying. We will get back to you shortly')
  end
end
