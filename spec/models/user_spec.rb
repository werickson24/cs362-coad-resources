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

  # after_initialize test
    # unknown method

  # belongs_to tests
  it { should belong_to(:organization).optional}

  # devise test
    # unknown method

  # validates tests

  it { should validate_presence_of(:email)}

  it do
    should validate_length_of(:email).
      is_at_least(1).
      is_at_most(255).
      on(:create)
  end

    # unknown test for validates

  it { should validate_uniqueness_of(:email).case_insensitive }

  it do
    should validate_presence_of(:password).
    on(:create)
  end

  it do
    should validate_length_of(:password).
      is_at_least(7).
      is_at_most(255).
      on(:create)
  end

end
