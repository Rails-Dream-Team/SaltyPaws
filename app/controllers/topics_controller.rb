class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topic_path(@topic)
    else
      render :new
    end
  end

  def show
    @topic = get_topic
  end

  def edit
    @topic = get_topic
  end

  def update
    @topic = get_topic
    if @topic.update_attributes(topic_params)
      redirect_to @topic
    else
      render :edit
    end
  end

  def destroy
    @topic = get_topic
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
