require 'rails_helper'

RSpec.describe Organization, type: :model do

  it "has a email" do
    organization = Organization.new
    expect(organization).to respond_to(:email)
  end

  it "has a name" do
    organization = Organization.new
    expect(organization).to respond_to(:name)
  end

  it "has a phone" do
    organization = Organization.new
    expect(organization).to respond_to(:phone)
  end

  it "has status" do
    organization = Organization.new
    expect(organization).to respond_to(:status)
  end

  it "has a primary_name" do
    organization = Organization.new
    expect(organization).to respond_to(:primary_name)
  end

  it "has a secondary_name" do
    organization = Organization.new
    expect(organization).to respond_to(:secondary_name)
  end

  it "has a secondary_phone" do
    organization = Organization.new
    expect(organization).to respond_to(:secondary_phone)
  end

  it "has a description" do
    organization = Organization.new
    expect(organization).to respond_to(:description)
  end

  it "has a rejection_reason" do
    organization = Organization.new
    expect(organization).to respond_to(:rejection_reason)
  end


end
