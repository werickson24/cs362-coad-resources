require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe "get index" do
    context "for logged out users" do
      it "redirects to a login page" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "for logged in admin" do
      it "returns all tickets" do
        user = create(:user, :admin)
        sign_in user
        get :index
        expect(response).to be_successful
        expect(assigns(:status_options)).to eq(['Open', 'Captured', 'Closed'])
        expect(assigns(:tickets)).to be_a(Pagy::Collection)
      end
    end
    context "for logged in unapproved organization" do
      it "returns only open tickets" do
        organization = create(:organization)
        user = create(:user, organization: organization)
        sign_in user
        get :index
        expect(response).to be_successful
        expect(assigns(:status_options)).to eq(['Open'])
        expect(assigns(:tickets)).to be_a(Pagy::Collection)
      end
    end
    context "for logged in approved organization" do
      it "returns all tickets specific to the users organization" do
        organization = create(:organization, :approved)
        user = create(:user, organization: organization)
        sign_in user
        get :index
        expect(response).to be_successful
        expect(assigns(:status_options)).to eq(['Open', 'My Captured', 'My Closed'])
        expect(assigns(:tickets)).to be_a(Pagy::Collection)
      end
    end
  end
end
