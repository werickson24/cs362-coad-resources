require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do
  before do
    @region = create(:region, name: "testRegion")
    @user = create(:user, :admin)
  end
  it "can delete a region from the homescreen" do
    log_in_as(@user)
    visit root_path
    click_on 'Regions'
    click_on 'testRegion'
    click_on 'Delete'
    expect(page.body).to have_text('Region testRegion was deleted.')

  end

end
