require 'rails_helper'

RSpec.describe RegionsController, type: :controller do
  describe "index" do

  end
  describe "show" do

  end
  describe "new" do

  end

  context 'as an admin user' do
		let(:user){create(:user, :admin)}
		before(:each){sign_in(user)}

    let(:region){create(:region)}

    describe "GET #index" do
      it {
        get :index
        expect(response).to be_successful
      }
    end

    describe "PATCH #show" do
      it {
        ticket = create(:ticket)
        patch :show, params: {id: ticket.id}
        expect(response).to be_successful
      }
    end

    describe "GET #new" do
      it{
        get :new
        expect(response).to be_successful
      }
    end

		describe "POST #create" do
      it {
        post(:create, params: { region: attributes_for(:region) })	# attributes_for passes parameters for the region.
        expect(response).to redirect_to(regions_path)
      }
      it {
        expect_any_instance_of(Region).to receive(:save).and_return(false) # Now if save is called, it will return false
        post(:create, params: { region: attributes_for(:region) })
        expect(response).to be_successful
      }
    end

    describe "GET #edit" do
      it {
        get(:edit, params: {id: region.id})
        expect(response).to be_successful
      }
    end

    describe "PATCH #update" do
      it "updates" do
        patch(:update, params: {id: region.id, region: attributes_for(:region)})  
        expect(response).to redirect_to(region)
      end
      it "does not update" do
        expect_any_instance_of(Region).to receive(:update).and_return(false)
        patch(:update, params: {id: region.id, region: attributes_for(:region)})  
        expect(response).to be_successful
      end
    end

    describe "DELETE #destroy" do
      let(:regionDelete){create(:region)}
      it "deletes a region" do
        delete(:destroy, params: {id: regionDelete.id})

        expect(response).to redirect_to(regions_path)
        expect(flash[:notice]).to match(/Region #{regionDelete.name} was deleted/)
        expect(Region.where(id: regionDelete.id)).to be_empty
      end
    end


  end

  describe "edit" do

  end
  describe "update" do

  end
  describe "destroy" do

  end
end
