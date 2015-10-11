class ContestsController < ApplicationController
  before_action :find_contest, only: :show
  before_action :set_user
  before_action :find_topic, only: :new

  def index
    @contests = Contest.all
  end

  def new
    @contest = Contest.new
    @contest.word = @topic.word
    @contest.save
    @post = Post.new
  end

  def show
  end

  private

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def find_contest
    @contest = Contest.find(params[:id])
  end
end
