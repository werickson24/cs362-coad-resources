require 'rails_helper'

RSpec.describe Organization, type: :model do

  let(:organization) { Organization.new }

  it "has a email" do
    expect(organization).to respond_to(:email)
  end

  it "has a name" do
    expect(organization).to respond_to(:name)
  end

  it "has a phone" do
    expect(organization).to respond_to(:phone)
  end

  it "has status" do
    expect(organization).to respond_to(:status)
  end

  it "has a primary_name" do
    expect(organization).to respond_to(:primary_name)
  end

  it "has a secondary_name" do
    expect(organization).to respond_to(:secondary_name)
  end

  it "has a secondary_phone" do
    expect(organization).to respond_to(:secondary_phone)
  end

  it "has a description" do
    expect(organization).to respond_to(:description)
  end

  it "has a rejection_reason" do
    expect(organization).to respond_to(:rejection_reason)
  end

  it "has liability_insurance" do
    expect(organization).to respond_to(:liability_insurance)
  end

  it "has a title" do
    expect(organization).to respond_to(:title)
  end

  it "has transportation" do
    expect(organization).to respond_to(:transportation)
  end

  # unknown test for attr_accessor

  # enum tests

  it do
    should define_enum_for(:status).
      with_values([:approved, :submitted, :rejected, :locked])
  end

  it do
    should define_enum_for(:transportation).
      with_values([:yes, :no, :maybe])
  end

  # unknown test for after initialze

  # has tests

  it {should have_many(:users)}

  it {should have_many(:tickets)}

  it { should have_and_belong_to_many(:resource_categories) }

  # validates tests

  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:phone)}
  it { should validate_presence_of(:status)}
  it { should validate_presence_of(:primary_name)}
  it { should validate_presence_of(:secondary_name)}
  it { should validate_presence_of(:secondary_phone)}

  it do
    should validate_length_of(:email).
      is_at_least(1).
      is_at_most(255).
      on(:create)
  end

  # unknown test for validates

  it { should validate_uniqueness_of(:email).case_insensitive }

  it do
    should validate_length_of(:name).
      is_at_least(1).
      is_at_most(255).
      on(:create)
  end

  it { should validate_uniqueness_of(:name).case_insensitive }

  it do
    should validate_length_of(:description).
      is_at_most(1020).
      on(:create)
  end
  

  # Testing functions

  it "has the name 'test-name'" do
    organization = Organization.new(name: 'test-name')
    expect(organization.to_s).to eq('test-name')
  end

  it "changes status to 'approved'" do
    organization = Organization.new()
    organization.approve
    expect(organization.status).to eq('approved')
  end

  it "changes status to 'rejected'" do
    organization = Organization.new()
    organization.reject
    expect(organization.status).to eq('rejected')
  end
  
  it "has a default status of 'submitted'" do
    organization = Organization.new()
    expect(organization.status).to eq('submitted')
  end

end
