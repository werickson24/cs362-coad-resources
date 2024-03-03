require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe "DELETE destroy" do
    context "as a logged out user" do
      it "redirects to dashboard" do
        ticket = create(:ticket)
        delete :destroy, params: { id: ticket.id }
        #pp(response)
        expect(response).to redirect_to(dashboard_path)# << '#tickets')
      end
    end

    context "as a logged-in non-organization approved user" do
      it "redirects to dashboard" do
        user = create(:user)
        sign_in(user)
        ticket = create(:ticket)
        delete :destroy, params: { id: ticket.id }
        #expect(response).to redirect_to(dashboard_path << '#tickets:organization')
        expect(response).to redirect_to(dashboard_path)# << '#tickets')
      end
    end

    context "as a logged-in organization approved user" do
      it "redirects to dashboard" do
        user = create(:user, :organization_approved)
        sign_in(user)
        ticket = create(:ticket, :organization_id => nil)#user.organization.id)
        delete :destroy, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)# << '#tickets')
      end
    end

    context "as an admin user" do
      it "redirects to dashboard" do
        user = create(:user, :admin)
        sign_in(user)
        ticket = create(:ticket)
        delete :destroy, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets')
      end
    end
  end

  describe "POST #capture" do
    context "as a logged out user" do
      it "redirects to dashboard" do
        ticket = create(:ticket)
        post :capture, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "as a logged-in non-organization approved user" do
      it "redirects to dashboard" do
        user = create(:user)
        sign_in(user)
        ticket = create(:ticket)
        post :capture, params: { id: ticket.id }
        #expect(response).to redirect_to(dashboard_path << '#tickets:organization')
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "as a logged-in organization approved user" do
      it "redirects to dashboard" do
        user = create(:user, :organization_approved)
        sign_in(user)
        ticket = create(:ticket, :organization_id => nil)#user.organization.id)
        post :capture, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:open')
      end
    end

    context "as a logged-in organization approved user, without permission to capture this ticket" do
      it "should be successful" do
        user = create(:user, :organization_approved)
        sign_in(user)
        ticket = create(:ticket)# , :organization_id => user.organization.id)
        post :capture, params: { id: ticket.id }
        expect(response).to be_successful
      end
    end

    context "as an admin user" do
      it "redirects to dashboard" do
        user = create(:user, :admin)
        sign_in(user)
        ticket = create(:ticket)
        post :capture, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path) #<< '#tickets:captured')
      end
    end
  end

  describe "PATCH #release" do
    context "as a logged out user" do
      it "redirects to dashboard" do
        ticket = create(:ticket)
        post :release, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "as a logged-in non-organization approved user" do
      it "redirects to dashboard" do
        user = create(:user)
        sign_in(user)
        ticket = create(:ticket)
        post :release, params: { id: ticket.id }
        #expect(response).to redirect_to(dashboard_path << '#tickets:organization')
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "as a logged-in organization approved user" do
      it "redirects to dashboard" do
        user = create(:user, :organization_approved)
        sign_in(user)
        ticket = create(:ticket, :organization_id => user.organization.id)
        post :release, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:organization')
      end
    end

    context "as a logged-in organization approved user, without permission to release this ticket" do
      it "should be successful" do
        user = create(:user, :organization_approved)
        sign_in(user)
        ticket = create(:ticket)
        post :release, params: { id: ticket.id }
        expect(response).to be_successful
      end
    end

    context "as an admin user" do
      it "redirects to dashboard" do
        user = create(:user, :admin)
        sign_in(user)
        ticket = create(:ticket)
        post :release, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path) #<< '#tickets:captured')
      end
    end
  end

  describe "PATCH #close" do
    context "as a logged out user" do
      it "redirects to dashboard" do
        ticket = create(:ticket)
        patch :close, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "as a logged-in non-organization approved user" do
      it "redirects to dashboard" do
        user = create(:user)
        sign_in(user)
        ticket = create(:ticket)
        patch :close, params: { id: ticket.id }
        #expect(response).to redirect_to(dashboard_path << '#tickets:organization')
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "as a logged-in organization approved user" do
      it "redirects to dashboard" do
        user = create(:user, :organization_approved)
        sign_in(user)
        ticket = create(:ticket, :organization_id => user.organization.id)
        patch :close, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:organization')
      end
    end

    context "as a logged-in organization approved user, without permission to close this ticket" do
      it "should be successful" do
        user = create(:user, :organization_approved)
        sign_in(user)
        ticket = create(:ticket)
        patch :close, params: { id: ticket.id }
        expect(response).to be_successful
      end
    end

    context "as an admin user" do
      it "redirects to dashboard" do
        user = create(:user, :admin)
        sign_in(user)
        ticket = create(:ticket)
        patch :close, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:open')
      end
    end
  end
  # describe "new" do
  #
  # end
  # describe "create" do
  #   context "as a logged out user" do
  #     it "creates ticket" do
  #       ticket = create(:ticket)
  #       post(:create, params: { ticket: attributes_for(:ticket)})
  #       expect(response).to redirect_to(ticket_submitted_path)
  #
  #     end
  #   end
  # end
  # describe "show" do
  #
  # end
  # describe "capture" do
  #
  # end
  # describe "release" do
  #
  # end
  # describe "PATCH #close" do
  #   context "as a logged out user" do # need one for different type of users.
  #     it "redirects to dashboard" do
  #       #ticket = create(:ticket)
  #       patch :close, params: { id: "DUMMY"}
  #       expect(response).to redirect_to(dashboard_path)
  #     end
  #   end
  #   context "as a logged in admin user" do
  #     let(:user){create(:user, :admin)}
  #     before(:each){sign_in(user)}
  #     it "redirects to dashboard/#tickets:open" do
  #       patch :close, params: { id: "DUMMY"}
  #       expect(response).to redirect_to(dashboard_path)
  #     end
  #   end
  # end
  #
  # describe "destroy" do
  #
  # end
end
