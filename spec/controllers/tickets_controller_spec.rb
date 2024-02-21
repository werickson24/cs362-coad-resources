require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe "new" do

  end
  describe "create" do

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
  end

  describe "destroy" do

  end
end
