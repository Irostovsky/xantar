class PaymentsController < ApplicationController

  def show
  end

  def create

    credit_card = ActiveMerchant::Billing::CreditCard.new(
      :brand               => "visa",
      :number             => "4676949199749717",
      :verification_value => "123",
      :month              => 2,
      :year               => 2019,
      :first_name         => "Card",
      :last_name          => "Holder2"
    )

    if credit_card.valid?
      # or gateway.purchase to do both authorize and capture
      response = GATEWAY.authorize(900, credit_card, :ip => "127.0.0.1")
      if response.success?
        GATEWAY.capture(900, response.authorization)
        puts "Purchase complete!"
      else
        p response
        puts "Error: #{response.message}"
      end
    else
      puts "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
    end
  end
end
