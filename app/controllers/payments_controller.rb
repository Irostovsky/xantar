class PaymentsController < ApplicationController
  before_filter :find_post

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new payment_params
    if @payment.valid?
      render text: 'valid'
    else
      render :new
    end
  end

private

  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :card_type, :card_number, :card_verification, :card_expires_on)
  end

  def find_post
    @post = Post.find params[:post_id]
  end
end
