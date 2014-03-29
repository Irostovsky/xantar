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
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end

  def purchase
    amount = Money.new(Xantar::Application.config.post_amount, "USD").cents
    response = GATEWAY.purchase(amount, credit_card, :ip => "127.0.0.1")
    post.update_attribute(:purchased_at, Time.zone.now) if response.success?
    self.success = response.success?
    p self.params = response.params
    self.save
    response.success?
  end
end


    # credit_card = ActiveMerchant::Billing::CreditCard.new(
    #   :brand               => "visa",
    #   :number             => "4676949199749717",
    #   :verification_value => "123",
    #   :month              => 2,
    #   :year               => 2019,
    #   :first_name         => "Card",
    #   :last_name          => "Holder2"
    # )

    # if credit_card.valid?
    #   # or gateway.purchase to do both authorize and capture
    #   response = GATEWAY.authorize(900, credit_card, :ip => "127.0.0.1")
    #   if response.success?
    #     GATEWAY.capture(900, response.authorization)
    #     puts "Purchase complete!"
    #   else
    #     p response
    #     puts "Error: #{response.message}"
    #   end
    # else
    #   puts "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
    # end
