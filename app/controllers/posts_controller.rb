class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @post = get_post
  end

  def edit
    @post = get_post
  end

  def update
    @post = get_post
    if @post.uppdate_attributes(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def get_post
    Post.find(params[:id])
  end

end
