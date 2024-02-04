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
  it "should tell you if the ticket is open or not from function `open?`" do
    ticket1 = Ticket.new(closed: false)
    ticket2 = Ticket.new(closed: true)
    expect(ticket1.open?).to eq(true)
    expect(ticket2.open?).to eq(false)
  end

  it "should tell you if the ticket is connected to an organization from function `captured?`" do
    organization = Organization.new()
    ticket1 = Ticket.new()
    ticket2 = Ticket.new(organization: organization)
    expect(ticket1.captured?).to eq(false)
    expect(ticket2.captured?).to eq(true)
  end

  it "should give you the correct name of the ticket from function `to_s`" do
    ticket = Ticket.new(id: 1)
    expect(ticket.to_s).to eq("Ticket 1")
  end


  # --- Scope Tests ---
  describe 'the status of the Ticket, open or closed' do

    it ".open" do
      region = Region.create! :name => "testRegion"
      resourceCategory = ResourceCategory.create! :name => "testCategory"
  
      ticketOpen = Ticket.create! :closed => false, :organization_id => nil, :name => "TicketOpen", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      ticketClosed = Ticket.create! :closed => true, :organization_id => nil, :name => "TicketClosed", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      
      expect(Ticket.open).to include(ticketOpen)
      expect(Ticket.open).not_to include(ticketClosed)
    end

    it ".closed" do
      region = Region.create! :name => "testRegion"
      resourceCategory = ResourceCategory.create! :name => "testCategory"
  
      ticketOpen = Ticket.create! :closed => false, :organization_id => nil, :name => "TicketOpen", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      ticketClosed = Ticket.create! :closed => true, :organization_id => nil, :name => "TicketClosed", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id

      expect(Ticket.closed).to include(ticketClosed)
      expect(Ticket.closed).not_to include(ticketOpen)
    end
  end

  describe 'dealing with the organization objects in scope' do
    it ".all_organization" do

      # ------- Needed Objects to create Objects for testing --------
      region = Region.create! :name => "testRegion"
      resourceCategory = ResourceCategory.create! :name => "testCategory"
      # ------------------------------------------------------------
      
      # ------- Objects for Testing ------------
      organization1 = Organization.create!(email: "testEmail@example.com", name: "testOrg1", phone:"+41 44 111 22 33", status: :approved, primary_name: "TestPrimName", secondary_name: "TestSecName", secondary_phone: '+41 44 111 22 32')

      ticketOpenOrg = Ticket.create! :closed => false, :organization_id => organization1.id, :name => "TicketOpen", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      ticketOpenNoOrg = Ticket.create! :closed => false, :organization_id => nil, :name => "TicketOpen", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      ticketClosedOrg = Ticket.create! :closed => true, :organization_id => organization1.id, :name => "TicketClosed", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      ticketClosedNoOrg = Ticket.create! :closed => true, :organization_id => nil, :name => "TicketClosed", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      # -----------------------------------------


      # Pass Test
      expect(Ticket.all_organization).to include(ticketOpenOrg)

      # Fail Tests
      expect(Ticket.all_organization).not_to include(ticketOpenNoOrg)
      expect(Ticket.all_organization).not_to include(ticketClosedOrg)
      expect(Ticket.all_organization).not_to include(ticketClosedNoOrg)
      
    end


    it ".organization" do
      # ------- Needed Objects to create Objects for testing --------
      region = Region.create! :name => "testRegion"
      resourceCategory = ResourceCategory.create! :name => "testCategory"
      # -------------------------------------------------------------
      
      # ------- Objects for Testing ------------
      organization1 = Organization.create!(email: "testEmail@example.com", name: "testOrg1", phone:"+41 44 111 22 33", status: :approved, primary_name: "TestPrimName", secondary_name: "TestSecName", secondary_phone: '+41 44 111 22 32')
      ticketOpenOrg = Ticket.create! :closed => false, :organization_id => organization1.id, :name => "TicketOpen", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      ticketClosedOrg = Ticket.create! :closed => true, :organization_id => organization1.id, :name => "TicketClosed", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      # ----------------------------------------

      result = Ticket.organization(organization1.id)
      expect(result).to include(ticketOpenOrg)
      expect(result).not_to include(ticketClosedOrg)
    end


    it "closed_organization" do
      # .------- Needed Objects to create Objects for testing --------.
      region = Region.create! :name => "testRegion"
      resourceCategory = ResourceCategory.create! :name => "testCategory"
      # '-------------------------------------------------------------'
      
      # ------- Objects for Testing ------------
      organization1 = Organization.create!(email: "testEmail@example.com", name: "testOrg1", phone:"+41 44 111 22 33", status: :approved, primary_name: "TestPrimName", secondary_name: "TestSecName", secondary_phone: '+41 44 111 22 32')
      ticketOpenOrg = Ticket.create! :closed => false, :organization_id => organization1.id, :name => "TicketOpen", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      ticketClosedOrg = Ticket.create! :closed => true, :organization_id => organization1.id, :name => "TicketClosed", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory.id
      # ----------------------------------------
      
      result = Ticket.closed_organization(organization1.id)
      expect(result).to include(ticketClosedOrg)
      expect(result).not_to include(ticketOpenOrg)
    end

  end

  describe "testing scopes involving region" do
    it ".region" do
      # .------- Needed Objects to create Objects for testing ----------.
      resourceCategory = ResourceCategory.create! :name => "testCategory"
      # '---------------------------------------------------------------'

      region1 = Region.create! :name => "testRegion1"
      region2 = Region.create! :name => "testRegion2"

      ticketRegion1 = Ticket.create! :closed => false, :organization_id => nil, :name => "TicketRegion1", :phone =>'+41 44 111 22 33', :region_id => region1.id, :resource_category_id => resourceCategory.id
      ticketRegion2 = Ticket.create! :closed => false, :organization_id => nil, :name => "TicketRegion2", :phone =>'+41 44 111 22 33', :region_id => region2.id, :resource_category_id => resourceCategory.id

      result = Ticket.region(region1.id)
      expect(result).to include(ticketRegion1)
      expect(result).not_to include(ticketRegion2)

    end
  end

  describe "testing scopes involving resource_category" do
    it ".resource_category" do
      # .------- Needed Objects to create Objects for testing ----------.
      region = Region.create! :name => "testRegion"
      # '---------------------------------------------------------------'
      resourceCategory1 = ResourceCategory.create! :name => "testCategory1"
      resourceCategory2 = ResourceCategory.create! :name => "testCategory2"

      ticketResourceCategory1 = Ticket.create! :closed => false, :organization_id => nil, :name => "TicketRegion1", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory1.id
      ticketResourceCategory2 = Ticket.create! :closed => false, :organization_id => nil, :name => "TicketRegion2", :phone =>'+41 44 111 22 33', :region_id => region.id, :resource_category_id => resourceCategory2.id

      result = Ticket.resource_category(resourceCategory1)
      expect(result).to include(ticketResourceCategory1)
      expect(result).not_to include(ticketResourceCategory2)
    end
  end


end
