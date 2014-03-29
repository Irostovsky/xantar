class PaymentsController < ApplicationController
  before_filter :find_post

  def new
    @payment = Payment.new
  end

  def create
    @payment = @post.payments.build payment_params
    if @payment.valid?
      if @payment.purchase
        flash[:notice] = "Your successfully paid and your post has been submitted!"
        redirect_to root_path
      else
        flash[:alert] = "Ups something is went wrong! #{@payment.params['message']}"
        render :failure
      end
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
