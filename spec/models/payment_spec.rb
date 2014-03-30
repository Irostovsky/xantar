require 'spec_helper'

describe Payment do
  describe "validation" do
    it "should be vaild" do
      payment = create :payment
      expect(payment).to be_valid
    end

    [:first_name, :last_name, :card_type, :card_number, :card_verification, :card_expires_on].each do |col|
      it { should validate_presence_of(col) }
    end

    it "should vaildate credit card" do
      payment = build :payment, card_number: 'bad_number'
      expect(payment).not_to be_valid
      expect(payment.errors[:base]).to eq ["Number is required"]
    end
  end

  describe "#purchase" do
    it "should process success" do
      payment = create :success_payment
      expect(payment.purchase).to eq true
      expect(payment.post.purchased_at).not_to eq nil
      expect(payment.success).to eq true
      expect(payment.params['paid_amount']).not_to eq nil
    end

    it "should process failure" do
      payment = create :failure_payment
      expect(payment.purchase).to eq false
      expect(payment.post.purchased_at).to eq nil
      expect(payment.success).to eq false
      expect(payment.params['paid_amount']).not_to eq nil
    end
  end
end
