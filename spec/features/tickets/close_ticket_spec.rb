require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do
  before do
      @user = create(:user, :organization_approved)
      @ticket = create(:ticket, name: "testTicket")
  end

  it "can close a ticket from the home screen" do
      log_in_as(@user)
      visit root_path
      click_on "Dashboard"
      click_on "testTicket"
      #puts(page.body)
  end


end
