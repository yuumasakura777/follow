class PostsController < ApplicationController
  def index
    @posts=Post.all.order(created_at: :desc)
  end

  def new
    @post=Post.new
  end

  def create
    @post=current_user.posts.new(post_params)

    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
