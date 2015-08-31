class PostsController < ApplicationController
  def index
    @posts = Post.all
    authorize @posts
  end

  def new
    @topic = get_topic
    @post = Post.new
    authorize @post
  end

  def create
    @topic = get_topic
    @post = @topic.posts.new(post_params)
    authorize @post
    @post.user_id = current_user.id
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
