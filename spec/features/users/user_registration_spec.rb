require 'rails_helper'

RSpec.describe 'User registration', type: :feature do

  it "user can sign up" do
    email = generate(:email)
    visit root_path
    click_on('Sign up')
    fill_in 'user_email', with: email
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button('commit')
    expect(page.body).to have_text('confirmation link has been sent')
  end

end
