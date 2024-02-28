require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DashboardHelper, type: :helper do

  let(:orgRejected){create(:user, :organization_rejected)}
  let(:admin){create(:user, :admin)}
  let(:orgUnapproved){create(:user, :organization_unapproved)}
  let(:orgApproved){create(:user, :organization_approved)}

  describe "tests #dashboard_for" do
    it "is rejected organization" do
      expect(helper.dashboard_for(orgRejected)).to eq('create_application_dashboard')
    end
    it "is admin" do
      expect(helper.dashboard_for(admin)).to eq("admin_dashboard")
    end
    it "is submitted organization" do
      expect(helper.dashboard_for(orgUnapproved)).to eq("organization_submitted_dashboard")
    end
    it "is approved organization" do
      expect(helper.dashboard_for(orgApproved)).to eq("organization_approved_dashboard")
    end
  end

end
