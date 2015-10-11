class ContestsController < ApplicationController
  before_action :find_contest, only: [:show, :continue_contest]
  before_action :set_user
  before_action :find_topic, only: :new
  before_action :create_post, only: [:new, :continue_contest]

  def index
    @contests = Contest.all.order("updated_at DESC")
    # if we want to display only finished contests
    #@contests = Contest.all.where("status = 'finished'").order("updated_at DESC")
  end

  def new
    @contest = Contest.new
    @contest.word = @topic.word
    @contest.save
  end

  def continue_contest
  end

  def show
  end

  private

  def create_post
    @post = Post.new
  end

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
