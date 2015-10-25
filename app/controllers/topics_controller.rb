class TopicsController < ApplicationController
  before_action :set_topic, only: :index
  before_action :set_user, only: :index
  before_action :authenticate_user!

  def index
    @unfinished_contests = Contest.all.where(aasm_state: :started)
    @unplayable_contests = @unfinished_contests & @user.contests
  end

  private

  def set_topic
    @topic = Topic.limit(1).order("RANDOM()").first
  end

  def set_user
    @user = current_user
  end

end
