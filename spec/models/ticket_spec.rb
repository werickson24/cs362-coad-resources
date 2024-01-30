require 'rails_helper'

RSpec.describe Ticket, type: :model do

  it "exists" do
    Ticket.new
  end

  it "has a name" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:name)
  end

  it "has a phone" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:phone)
  end

  it "has a region_id" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:region_id)
  end

  it "has a resource_category_id" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:resource_category_id)
  end

  # belongs_to tests

  it { should belong_to(:region)}

  it { should belong_to(:resource_category)}

  it { should belong_to(:organization).optional}

  # validates tests

  it { should validate_presence_of(:name)}

  it { should validate_presence_of(:phone)}

  it { should validate_presence_of(:region_id)}

  it { should validate_presence_of(:resource_category_id)}

  it do
    should validate_length_of(:name).
      is_at_least(1).
      is_at_most(255).
      on(:create)
  end

  it do
    should validate_length_of(:description).
      is_at_most(1020).
      on(:create)
  end

  # unknown test for scope


  # --- Function Tests ---
  it "open?" do
    ticket1 = Ticket.new(closed: false)
    ticket2 = Ticket.new(closed: true)
    expect(ticket1.open?).to eq(true)
    expect(ticket2.open?).to eq(false)
  end

  it "captured?" do
    organization = Organization.new()
    ticket1 = Ticket.new()
    ticket2 = Ticket.new(organization: organization)
    expect(ticket1.captured?).to eq(false)
    expect(ticket2.captured?).to eq(true)
  end

  it "to_s" do
    ticket = Ticket.new(id: 1)
    expect(ticket.to_s).to eq("Ticket 1")
  end

end
