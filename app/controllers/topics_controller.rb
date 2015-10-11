class TopicsController < ApplicationController
  before_action :set_topic, only: :index

  def index
  end

  private

  def set_topic
    @topic = Topic.limit(1).order("RANDOM()").first
  end

end
