require 'rails_helper'

RSpec.describe User, type: :model do

  it "exists" do
    User.new
  end

  it "has a email" do
    user = User.new
    expect(user).to respond_to(:email)
  end

  it "has a role" do
    user = User.new
    expect(user).to respond_to(:role)
  end

  # enum test
  it do
    should define_enum_for(:role).
      with_values([:admin, :organization])
  end

  # belongs_to tests
  it { should belong_to(:organization).optional}


end
