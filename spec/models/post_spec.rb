require 'spec_helper'

describe Post do
  describe "validation" do
    it "should be valid" do
      post = create :post
      expect(post).to be_valid
    end
    it { should validate_presence_of(:content) }
  end
end
