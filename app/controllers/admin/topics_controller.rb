class Admin::TopicsController < ApplicationController
  def index
    @topic = Topic.new
    @topics = Topic.all
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.save
    redirect_to admin_topics_path
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update(topic_params)
    redirect_to admin_topics_path
  end

  private
    def topic_params
      params.require(:topic).permit(:topic_name)
    end
end
