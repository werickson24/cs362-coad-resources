require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do

  let(:admin){create(:user, :admin)}
  let(:user){create(:user)}
  let(:resource_category){create(:resource_category)}
  
  describe "GET #index" do
    context "as an admin" do
      before(:each){sign_in(admin)}
      it "get resource categories" do
        get :index
        expect(response).to be_successful
      end
    end
    context "as a user" do
      before(:each){sign_in(user)}
      it "get resource categories" do
        get :index
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "logged out" do
      it "get resource categories" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "GET #show" do
    context "as an admin" do
      before(:each){sign_in(admin)}
      it "nothing" do
      end
    end
    context "as a user" do
      before(:each){sign_in(user)}
      it "nothing" do

      end
    end
    context "logged out" do
      it "nothing" do
      end
    end
  end



  describe "GET #new" do
    context "as an admin" do
      before(:each){sign_in(admin)}
      it "be successful" do
        get :new
        expect(response).to be_successful
      end
    end
    context "as a user" do
      before(:each){sign_in(user)}
      it "redirect to dashboard" do
        get :new
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "logged out" do
      it "redirect to new session" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end




  end
  describe "POST #create" do
    context "as an admin" do
      before(:each){sign_in(admin)}
      it "saved" do
        post :create, params: {resource_category: attributes_for(:resource_category)}
        expect(response).to redirect_to(resource_categories_path)
        expect(flash[:notice]).to match(/Category successfully created/)
      end
      it "didn't save" do
        post :create, params: {resource_category: {name: nil}}
        expect(response).to be_successful

      end
    end
    context "as a user" do
      before(:each){sign_in(user)}
      it "redirects to dashboard" do
        post :create, params: {resource_category: attributes_for(:resource_category)}
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "logged out" do
      it "redirect to new session" do
        post :create, params: {resource_category: attributes_for(:resource_category)}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end



  describe "#edit" do
    context "as an admin" do
      before(:each){sign_in(admin)}
      it "nothing" do
      end
    end
    context "as a user" do
      before(:each){sign_in(user)}
      it "nothing" do
      end
    end
    context "logged out" do
      it "nothing" do
      end
    end
  end



  describe "PATCH #update" do
    context "as an admin" do
      before(:each){sign_in(admin)}
      it "saved" do
        patch :update, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
        expect(response).to redirect_to(:resource_category)
        expect(flash[:notice]).to match(/Category successfully updated/)
      end
      it "didnt save" do
        patch :update, params: {id: resource_category.id, resource_category: {name: nil}}
        expect(response).to be_successful
      end
    end
    context "as a user" do
      before(:each){sign_in(user)}
      it "redirects" do
        patch :update, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "logged out" do
      it "redirects" do
        patch :update, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end



  describe "PATCH #activate" do
    context "as an admin" do
      before(:each){sign_in(admin)}
      it "activate" do
        patch :activate, params: {id: resource_category.id}
        expect(response).to redirect_to(resource_category)
        expect(flash[:notice]).to match(/Category activated/)
      end
      it "did not activate" do
        expect_any_instance_of(ResourceCategory).to receive(:activate).and_return(false)
        patch :activate, params: {id: resource_category.id}
        expect(response).to redirect_to(resource_category)
        expect(flash[:alert]).to match(/There was a problem activating the category/)
      end

    end
    context "as a user" do
      before(:each){sign_in(user)}
      it "redirect" do
        patch :activate, params: {id: resource_category.id}
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "logged out" do
      it "redirect" do
        patch :activate, params: {id: resource_category.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end



  describe "deactivate" do
    context "as an admin" do
      before(:each){sign_in(admin)}
      it "deactivate" do
        patch :deactivate, params: {id: resource_category.id}
        expect(response).to redirect_to(resource_category)
        expect(flash[:notice]).to match(/Category deactivated/)
      end
      it "did not deactivate" do
        expect_any_instance_of(ResourceCategory).to receive(:deactivate).and_return(false)
        patch :deactivate, params: {id: resource_category.id}
        expect(response).to redirect_to(resource_category)
        expect(flash[:alert]).to match(/There was a problem deactivating the category/)
      end
    end
    context "as a user" do
      before(:each){sign_in(user)}
      it "redirect" do
        patch :deactivate, params: {id: resource_category.id}
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "logged out" do
      it "redirect" do
        patch :deactivate, params: {id: resource_category.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end



  describe "DELETE #destroy" do
    let(:resCatDelete){create(:resource_category)}
    context "as an admin" do
      before(:each){sign_in(admin)}
      it "delete resource category" do
        delete :destroy, params:{id: resCatDelete.id}
        expect(response).to redirect_to(resource_categories_path)
        expect(flash[:notice]).to match(/Associated tickets now belong to the 'Unspecified' category/)

      end
    end
    context "as a user" do
      before(:each){sign_in(user)}
      it "nothing" do
        delete :destroy, params:{id: resCatDelete.id}
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context "logged out" do
      it "nothing" do
        delete :destroy, params:{id: resCatDelete.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
