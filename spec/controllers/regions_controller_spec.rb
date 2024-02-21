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

    let(:region){create(:region)} # MAYBE
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
  end

  describe "edit" do

  end
  describe "update" do

  end
  describe "destroy" do

  end
end
