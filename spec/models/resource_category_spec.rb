require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  it "exists" do
    ResourceCategory.new
  end

  it "has a name" do
    resourceCategory = ResourceCategory.new
    expect(resourceCategory).to respond_to(:name)
  end

end
