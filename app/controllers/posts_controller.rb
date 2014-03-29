class PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def create
    @post = Post.new post_params
    if @post.save
      go_to new_post_payment_path(@post)
    else
      render :new
    end
  end

 private

  def post_params
    params.require(:post).permit(:content)
  end
end
