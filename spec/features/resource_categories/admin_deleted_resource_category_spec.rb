require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do

  before do
    @region = create(:resource_category, name: "testCategory")
    @user = create(:user, :admin)
  end

  it "can delete a resource category from the home screen" do
    log_in_as(@user)
    visit root_path
    click_on "Categories"
    click_on "testCategory"
    click_on "Delete"
    expect(page.body).to have_text('Category testCategory was deleted.')
  end
end
