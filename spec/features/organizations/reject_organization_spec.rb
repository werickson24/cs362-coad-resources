require 'rails_helper'

RSpec.describe 'Rejecting an organization', type: :feature do

  before do
    @organization = create(:organization, name: "TestOrg")
    @user = create(:user, :admin)
  end

  it 'can be approved from the home screen' do
    log_in_as(@user)
    visit root_path
    click_on 'Organizations'
    click_on 'Pending'
    click_on 'Review'
    click_on 'Reject'
    expect(page.body).to have_text('Organization TestOrg has been rejected.')

  end

end
