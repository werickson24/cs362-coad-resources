require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
  let(:admin){create(:user, :admin)}
  let(:user){create(:user)}
  let(:resCat){create(:resource_categories)}
  
  describe "GET #index" do
    context "as an admin" do
      let "get resource categories" do
        before(:each){sign_in(admin)}
        get :index
        expect(response).to be_successful
      end
    end
    context "as a user" do
      let "get resource categories" do
        before(:each){sign_in(user)}
        get :index
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "logged out" do
      let "get resource categories" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "GET #show" do
    context "as an admin" do
      let "nothing" do
        before(:each){sign_in(admin)}
        get :show
        expect(response).to be_empty
      end
    end
    context "as a user" do
      let "nothing" do
        before(:each){sign_in(user)}
        get :show
        expect(response).to be_empty
      end
    end
    context "logged out" do
      let "nothing" do
        get :show
        expect(response).to be_empty
      end
    end
  end



  describe "GET #new" do
    context "as an admin" do
      let "be successful" do
        before(:each){sign_in(admin)}
        get :new
        expect(response).not_to be_successful
      end
    end
    context "as a user" do
      let "redirect to dashboard" do
        before(:each){sign_in(user)}
        get :new
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "logged out" do
      let "redirect to new session" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end




  end
  describe "create" do

  end
  describe "edit" do

  end
  describe "update" do

  end
  describe "activate" do

  end
  describe "deactivate" do

  end
  describe "destroy" do

  end
end
