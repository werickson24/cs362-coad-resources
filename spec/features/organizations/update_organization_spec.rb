require 'rails_helper'

RSpec.describe 'Updating an Organization', type: :feature do
  before do
    @user = create(:user, :organization_approved)
  end

  it "can edit the organization from the home screen" do
    log_in_as(@user)
    visit root_path
    click_on 'Dashboard'
    click_on 'Edit Organization'
    fill_in 'organization_name', with: 'New Name'
    fill_in 'organization_phone', with: '555-444-3333'
    fill_in 'organization_email', with: 'testing@email.com'
    fill_in 'organization_description', with: 'wow'
    click_on 'commit'
    expect(page.body).to have_text('New Name')

  end
end
