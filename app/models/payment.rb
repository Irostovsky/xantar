class Payment < ActiveRecord::Base
  belongs_to :post
  attr_accessor :card_number, :card_verification
  serialize :params

  validates :first_name, :last_name, :card_type, :card_number, :card_verification, :card_expires_on, presence: true
  validate :validate_card

  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors[:base] << message
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :brand              => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.try(:month),
      :year               => card_expires_on.try(:year),
      :first_name         => first_name,
      :last_name          => last_name
    )
  end

  def purchase
    amount = Money.new(Xantar::Application.config.post_amount, "USD").cents
    response = GATEWAY.purchase(amount, credit_card, :ip => "127.0.0.1")
    post.update_attribute(:purchased_at, Time.zone.now) if response.success?
    self.success = response.success?
    self.params = response.params
    self.save
    response.success?
  end
end