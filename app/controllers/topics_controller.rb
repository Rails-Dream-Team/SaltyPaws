class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show]

  def index
    @topics = Topic.all
    authorize @topics
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end

  def create
    if current_user
      @topic = current_user.topics.new(topic_params)
      save_if = true
    else
      @topic = Topic.new(topic_params)
      @topic.user_id = 0
      save_if = @topic.board[:public]
    end
    if save_if && @topic.save
      redirect_to @topic
    else
      render :new
    end
  end

  def show
    @topic = get_topic
    authorize @topic
  end

  def edit
    @topic = get_topic
    authorize @topic
  end

  def update
    @topic = get_topic
    authorize @topic
    if @topic.update_attributes(topic_params)
      redirect_to @topic
    else
      render :edit
    end
  end

  def destroy
    @topic = get_topic
    authorize @topic
    @topic.destroy
    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :board_id, posts_attributes: [:id, :topic_id, :user_id, :content])
  end

  def get_topic
    Topic.find(params[:id])
  end

end
