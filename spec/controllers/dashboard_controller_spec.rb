﻿require 'rails_helper'

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
      end
    end
    context "for logged in unapproved organization" do
      it "is successful" do
        user = create(:user, :organization_unapproved)
        sign_in user
        get :index
        expect(response).to be_successful
      end
    end
    context "for logged in approved organization" do
      it "be sucessful" do
        # organization = create(:organization)
        # organization.approve
        user = create(:user, :organization_approved)
        sign_in user
        get :index
        expect(response).to be_successful
      end
    end
  end
  describe "get ticket type" do
    it "open tickets" do
      user = create(:user, :admin)
      sign_in user
      get :index, params: {status: 'Open'}
      expect(response).to be_successful
    end
    it "closed tickets" do
      user = create(:user, :admin)
      sign_in user
      get :index, params: {status: 'Closed'}
      expect(response).to be_successful
    end
    it "captured tickets" do
      user = create(:user, :admin)
      sign_in user
      get :index, params: {status: 'Captured'}
      expect(response).to be_successful
    end
    it "my captured tickets" do
      user = create(:user, :admin)
      sign_in user
      get :index, params: {status: 'My Captured'}
      expect(response).to be_successful
    end
    it "my closed tickets" do
      user = create(:user, :admin)
      sign_in user
      get :index, params: {status: 'My Closed'}
      expect(response).to be_successful
    end
  end
end
