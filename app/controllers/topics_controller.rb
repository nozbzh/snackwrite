class TopicsController < ApplicationController
  before_action :set_topic, only: :index

  def index
    @unfinished_contests = Contest.all.where("status != 'finished'")
    #@playable_contests = @unfinished_contests.where(!users.inlude?(@user))
  end

  private

  def set_topic
    @topic = Topic.limit(1).order("RANDOM()").first
  end

  def set_user
    @user = current_user
  end

end
