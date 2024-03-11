require 'rails_helper'

RSpec.describe 'Capturing a ticket', type: :feature do
  before do
    #@organization = create(:organization, name: "TestOrg", :approved)
    #@user = create(:user, :organization_approved)
    @user = create(:user, organization_id: create(:organization, :approved, name:"TestOrg").id)
    @ticket = create(:ticket, name: "testTicket")

  end

  it 'captures a ticket from the home screen' do

    log_in_as(@user)
    visit root_path
    click_on 'Dashboard'
    click_on 'Tickets'
    page.select('My Captured', from: 'status')
    click_on "testTicket"
    #click_on "Capture"
    #puts(page.body)

  end

end
