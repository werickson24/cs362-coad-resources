require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe "test full_title" do
    it "gives base title" do
      expect(helper.full_title()).to eq 'Disaster Resource Network'
    end
    it "gives page title and base title " do
      expect(helper.full_title("Amazing Page")).to eq 'Amazing Page | Disaster Resource Network'
    end
  end


end
