require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  context 'as an organization user without an Organization' do
    
    # Create an admin to receiving emails in #create
    let(:admin){create(:user, :admin)}
    before(:each){sign_in(admin)}

    let(:user){create(:user)}   #default user is an organization
		before(:each){sign_in(user)}

    let(:organization){user.organization}

    describe "GET #index" do
      it "gets all organizations" do
        get :index
        expect(response).to be_successful
      end
    end

    describe "GET #new" do
      it "creates a new organization" do
        get :new
        expect(response).to be_successful
      end
    end
    
    describe "POST #create" do
      it "saves new organization and saves it to current user" do
        post :create, params: {organization: attributes_for(:organization)}
        expect(response).to redirect_to(organization_application_submitted_path)
      end

      it "it did not save, create new organization" do
        expect_any_instance_of(Organization).to receive(:save).and_return(false)
        post :create, params: {organization: attributes_for(:organization)}
        expect(response).to be_successful
      end
      
    end

    describe "PATCH #update" do
      it "redirects to dashboard_path" do
        post :update, params: { id: "", organization: {} }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "POST #approve" do
      it "redirects to dashboard" do
        post :approve, params: { id: "" }
        expect(response).to redirect_to(dashboard_path)
      end

    end

    describe "POST #reject" do
      it "redirects to dashboard" do
        post :reject, params: {id: ""}
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  
  context 'as an organization user without an Organization' do
    
    # Create an admin to receiving emails in #create
    let(:admin){create(:user, :admin)}
    before(:each){sign_in(admin)}

    let(:user){create(:user)}   #default user is an organization
		before(:each){sign_in(user)}

    let(:organization){user.organization}

    describe "GET #index" do
      it "gets all organizations" do
        get :index
        expect(response).to be_successful
      end
    end

    describe "GET #new" do
      it "creates a new organization" do
        get :new
        expect(response).to be_successful
      end
    end
    
    describe "POST #create" do
      it "saves new organization and saves it to current user" do
        post :create, params: {organization: attributes_for(:organization)}
        expect(response).to redirect_to(organization_application_submitted_path)
      end

      it "it did not save, create new organization" do
        expect_any_instance_of(Organization).to receive(:save).and_return(false)
        post :create, params: {organization: attributes_for(:organization)}
        expect(response).to be_successful
      end
      
    end

    describe "PATCH #update" do
      it "redirects to dashboard_path" do
        post :update, params: { id: "", organization: {} }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "POST #approve" do
      it "redirects to dashboard" do
        post :approve, params: { id: "" }
        expect(response).to redirect_to(dashboard_path)
      end

    end

    describe "POST #reject" do
      it "redirects to dashboard" do
        post :reject, params: {id: ""}
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

end
