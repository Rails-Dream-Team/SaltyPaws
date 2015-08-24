class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    if current_user
      @topic = Topic.new(topic_params)
      @topic.user_id = current_user.id
      if @topic.save
        redirect_to @topic
      else
        render :new
      end
    else
      redirect_to new_user_session_path
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
    params.require(:topic).permit(:title, :board_id)
  end

  def get_topic
    Topic.find(params[:id])
  end

end
