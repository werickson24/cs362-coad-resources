require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let(:resourceCategory) { ResourceCategory.new }

  it "exists" do
    ResourceCategory.new
  end

  it "has a name" do
    expect(resourceCategory).to respond_to(:name)
  end

  it "has active" do
    expect(resourceCategory).to respond_to(:active)
  end

end
