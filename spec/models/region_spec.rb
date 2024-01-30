require 'rails_helper'

RSpec.describe Region, type: :model do

  it "exists" do
    Region.new
  end

  it "has a name" do
    region = Region.new
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = Region.new(name: name)
    result = region.to_s
  end

  # has tests

  it {should have_many(:tickets)}

  # validates tests
  it { should validate_presence_of(:name)}

  it do
    should validate_length_of(:name).
      is_at_least(1).
      is_at_most(255).
      on(:create)
  end

  it { should validate_uniqueness_of(:name).case_insensitive }


  # --- Testing Functions ---
  it "has the correct name from to_s function" do
    region = Region.new(name: 'test-name')
    expect(region.to_s).to eq('test-name')
  end

  it "creating an unspecified region, its name should be 'Unspecified'" do
    unspecifiedRegion = Region.unspecified
    expect(unspecifiedRegion.name).to eq("Unspecified")
  end

end
