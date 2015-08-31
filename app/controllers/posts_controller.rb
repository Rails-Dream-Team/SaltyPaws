class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show]

  def index
    @topic = get_topic
    @posts = @topic.posts
    authorize @posts
  end

  def new
    @topic = get_topic
    if current_user || @topic.board.public
      @post = @topic.posts.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @topic = get_topic
    if current_user
      @post = @topic.posts.new(post_params)
      @post.user_id = current_user.id
    elsif @topic.board.public
      @post = @topic.posts.new(post_params)
      @post.user_id = 0
    else
      redirect_to new_user_session_path and return
    end
    if @post.save
      @topic.replies += 1
      @topic.save
      redirect_to @topic
    else
      render :new
    end
  end

  def show
    @post = get_topic_post
    authorize @post
  end

  def edit
    @post = get_topic_post
    authorize @post
  end

  def update
    @post = get_topic_post
    authorize @post
    if @post.update_attributes(post_params)
      redirect_to @topic
    else
      render :edit
    end
  end

  def destroy
    @post = get_topic_post
    authorize @post
    @post.destroy
    redirect_to @topic
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def get_topic
    Topic.find(params[:topic_id])
  end

  def get_topic_post
    @topic = Topic.find(params[:topic_id])
    @topic.posts.find(params[:id])
  end
end
