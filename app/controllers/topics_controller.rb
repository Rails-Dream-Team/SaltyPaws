class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to @topic
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
    if @topic.uppdate_attributes(topic_params)
      redirect_to @topic
    else
      render :edit
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title)
  end

  def get_topic
    Topic.find(params[:id])
  end
  
end
