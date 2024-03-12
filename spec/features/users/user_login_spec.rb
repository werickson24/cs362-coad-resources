require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do

  it "user can log in" do
    user = create(:user, :admin)
    visit root_path
    click_on('Log in')
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password'
    click_button('commit')
    expect(page.body).to have_text('Signed in successfully.')
  end

end
