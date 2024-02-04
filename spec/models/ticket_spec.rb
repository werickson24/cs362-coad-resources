require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let(:ticket) { build(:ticket) }

  it "has a name" do
    expect(ticket).to respond_to(:name)
  end

  it "has a phone" do
    expect(ticket).to respond_to(:phone)
  end

  it "has a region_id" do
    expect(ticket).to respond_to(:region_id)
  end

  it "has a resource_category_id" do
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
    ticketOpen = build(:ticket, closed:false)
    ticketClosed = build(:ticket, closed:true)
    expect(ticketOpen.open?).to eq(true)
    expect(ticketClosed.open?).to eq(false)
  end

  it "should tell you if the ticket is connected to an organization from function `captured?`" do
    ticketNoOrg = build(:ticket, organization: nil)
    ticketOrg = build(:ticket)
    expect(ticketNoOrg.captured?).to eq(false)
    expect(ticketOrg.captured?).to eq(true)
  end

  it "should give you the correct name of the ticket from function `to_s`" do
    ticket1 = build(:ticket, id:1)
    expect(ticket1.to_s).to eq("Ticket 1")
  end


  # --- Scope Tests ---

  let(:ticketOpenOrg) {create(:ticket, closed:false)}
  let(:ticketOpenNoOrg) {create(:ticket, closed:false, organization: nil)}

  let(:ticketClosedOrg) {create(:ticket, closed:true)}
  let(:ticketClosedNoOrg) {create(:ticket, closed:true, organization: nil)}

  describe 'the status of the Ticket, open or closed' do

    it ".open" do
      expect(Ticket.open).to include(ticketOpenNoOrg)

      expect(Ticket.open).not_to include(ticketOpenOrg)
      expect(Ticket.open).not_to include(ticketClosedOrg)
      expect(Ticket.open).not_to include(ticketClosedNoOrg)
    end

    it ".closed" do

      expect(Ticket.closed).to include(ticketClosedOrg)
      expect(Ticket.closed).to include(ticketClosedNoOrg)

      expect(Ticket.closed).not_to include(ticketOpenOrg)
      expect(Ticket.closed).not_to include(ticketOpenNoOrg)
    end
  end

  describe 'dealing with the organization objects in scope' do
    it ".all_organization" do
      expect(Ticket.all_organization).to include(ticketOpenOrg)

      expect(Ticket.all_organization).not_to include(ticketOpenNoOrg)
      expect(Ticket.all_organization).not_to include(ticketClosedOrg)
      expect(Ticket.all_organization).not_to include(ticketClosedNoOrg)
      
    end

    let(:orgToPass){create(:organization, id: 1)}
    let(:ticketOpenPassOrg){create(:ticket, closed:false, organization_id: orgToPass.id)}
    let(:ticketClosedPassOrg){create(:ticket, closed:true, organization_id: orgToPass.id)}
    
    it ".organization" do

      orgsWithID = Ticket.organization(orgToPass.id)
      expect(orgsWithID).to include(ticketOpenPassOrg)

      # Either Closed or have a different/no Organization
      expect(orgsWithID).not_to include(ticketClosedPassOrg)
      expect(orgsWithID).not_to include(ticketClosedNoOrg)
      expect(orgsWithID).not_to include(ticketClosedOrg)
      expect(orgsWithID).not_to include(ticketOpenNoOrg)
      expect(orgsWithID).not_to include(ticketOpenOrg)
      
    end


    it "closed_organization" do
    
      orgsWithID = Ticket.closed_organization(orgToPass.id)
      expect(orgsWithID).to include(ticketClosedPassOrg)
      
      expect(orgsWithID).not_to include(ticketOpenPassOrg)
      expect(orgsWithID).not_to include(ticketClosedNoOrg)
      expect(orgsWithID).not_to include(ticketClosedOrg)
      expect(orgsWithID).not_to include(ticketOpenNoOrg)
      expect(orgsWithID).not_to include(ticketOpenOrg)
    end

  end


  describe "testing scopes involving region" do
    let(:regToPass) {create(:region)}
    let(:ticketPassReg) {create(:ticket, region_id: regToPass.id)}
    
    it ".region" do
      regsWithID = Ticket.region(regToPass.id)
      expect(regsWithID).to include(ticketPassReg)
      expect(regsWithID).not_to include(ticketOpenNoOrg) #Any ticket with a different region would work
    end
  end


  describe "testing scopes involving resource_category" do
    let(:resCatToPass) {create(:resource_category)}
    let(:ticketPassResCat) {create(:ticket, resource_category_id: resCatToPass.id)}
    
    it ".resource_category" do
      resCatWithID = Ticket.resource_category(resCatToPass.id)
      expect(resCatWithID).to include(ticketPassResCat)
      expect(resCatWithID).not_to include(ticketOpenNoOrg)
    end
  end


end
