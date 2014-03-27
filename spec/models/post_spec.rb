require 'spec_helper'

describe Post do
  describe "validation" do
    it { should validate_presence_of(:content) }
  end
end
