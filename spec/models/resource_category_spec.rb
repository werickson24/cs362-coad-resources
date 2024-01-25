require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  it "exists" do
    ResourceCategory.new
  end

  let(:resourceCategory) { ResourceCategory.new }

  it "has a name" do
    expect(resourceCategory).to respond_to(:name)
  end

  it "has active" do
    expect(resourceCategory).to respond_to(:active)
  end

  # has tests

  it { should have_and_belong_to_many(:organizations) }

  it { should have_many(:tickets)}

  # validates tests

  it { should validate_presence_of(:name)}

  it do
    should validate_length_of(:name).
      is_at_least(1).
      is_at_most(255).
      on(:create)
  end

  it { should validate_uniqueness_of(:name).case_insensitive }

  # unknown test for scope

end
