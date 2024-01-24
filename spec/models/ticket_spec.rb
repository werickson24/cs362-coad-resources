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

  it { should belong_to(:region)}

  it { should belong_to(:resource_category)}

  it { should belong_to(:organization)}

end
