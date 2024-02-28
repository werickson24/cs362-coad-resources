require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe "new" do

  end
  describe "create" do
    context "as a logged out user" do
      it "creates ticket" do
        ticket = create(:ticket)
        post(:create, params: { ticket: attributes_for(:ticket)})
        expect(response).to redirect_to(ticket_submitted_path)

      end
    end
  end
  describe "show" do

  end
  describe "capture" do

  end
  describe "release" do

  end
  describe "PATCH #close" do
    context "as a logged out user" do # need one for different type of users.
      it "redirects to dashboard" do
        #ticket = create(:ticket)
        patch :close, params: { id: "DUMMY"}
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "as a logged in admin user" do
      let(:user){create(:user, :admin)}
      before(:each){sign_in(user)}
      it "redirects to dashboard/#tickets:open" do
        patch :close, params: { id: "DUMMY"}
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  describe "destroy" do

  end
end
