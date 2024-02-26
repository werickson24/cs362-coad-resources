require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do

  # create admin user
  # `log_in_as(admin)`
  it do
    user = create(:user, :admin)
    log_in_as(user)
    visit root_path
    click_on 'Regions'
    click_on 'Add Region'
    fill_in 'Name', with: 'Yolo202'
    click_on 'Add Region'
    expect(page.body).to have_test('Region successfully created')
  end
  # you will want to test the result page to make sure it contains the right info.
  #expect(page.body).to have_text('Whatever')
end
