require 'spec_helper'

describe Array do
  describe "#non_dub" do
    it "should return the same array if no dub" do
      expect([1,2,3].non_dub).to eq([1,2,3])
    end

    it "should return the array without dublicates" do
      a = [10, 1, 2, 10, 30, -1, 2]
      expect(a.non_dub).to eq([1, 30, -1])
    end

  end
end