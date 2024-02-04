require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do


  let(:resourceCategory) { build(:resource_category, name: 'test-name') }

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


  # ---- Function Test -----
  it "will gives the correct name for function to_s" do
    expect(resourceCategory.to_s).to eq('test-name')
  end

  it "will give the correct status when the function activate is called" do
    resourceCategory.activate
    expect(resourceCategory.active).to eq(true)
  end

  it "will give the correct status when the function deactivate is called" do
    resourceCategory.deactivate
    expect(resourceCategory.active).to eq(false)
  end

  it "will tell you if its deactivated when the function inactive? is called" do
    expect(resourceCategory.inactive?).to eq(false)
  end

  it "has the name 'Unspecified' when an unspecified Resource Category is made" do
    unspecResCat = ResourceCategory.unspecified
    expect(unspecResCat.name).to eq("Unspecified")
  end

  # ========== Scope Tests ================
  let(:resCatAct) {create(:resource_category, active: true) }
  let(:resCatInact) {create(:resource_category, active: false)}
  
  describe "Scope tests for if the resource category is active or not" do
    it ".active" do
      expect(ResourceCategory.active).to include(resCatAct)
      expect(ResourceCategory.active).not_to include(resCatInact)
    end

    it ".inactive" do
      expect(ResourceCategory.inactive).to include(resCatInact)
      expect(ResourceCategory.inactive).not_to include(resCatAct)
    end
  end

end
