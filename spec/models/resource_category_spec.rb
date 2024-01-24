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

end
