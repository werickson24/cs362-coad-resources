require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do
  before do
    @admin = create(:user, :admin)
    @ticket = create(:ticket, name: "testTicket")
  end

  it 'can be deleted from the home screen' do

    log_in_as(@admin)
    visit root_path
    click_on 'Dashboard'
    click_on 'testTicket'
    click_on 'Delete'
    expect(page.body).to have_text('was deleted')

  end
end
