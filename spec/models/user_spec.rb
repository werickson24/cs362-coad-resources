require 'rails_helper'

RSpec.describe User, type: :model do

  it "exists" do
    User.new
  end

  it "has a email" do
    user = User.new
    expect(user).to respond_to(:email)
  end

end
