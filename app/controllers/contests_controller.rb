class ContestsController < ApplicationController
  before_action :find_contest, only: [:show, :continue_contest, :create_post]
  before_action :find_topic, only: [:new, :create]
  before_action :initiate_post, only: [:new, :continue_contest]
  before_action :set_unfinished_contests, only: [:new, :continue_contest, :create_post]

  def index
    @contests = Contest.finished.order("updated_at DESC")
    @unfinished_contests = Contest.started
  end

  def show
    @next_contest = Contest.find_for_vote(current_user)
  end

  def create
    @contest = Contest.new
    @contest.topic = @topic
    if @contest.save
      @post = @contest.posts.new(post_params.merge(user: current_user))
      if @contest.aasm_state == "new"
        @contest.make_started!
      elsif @contest.aasm_state == "started"
        @contest.make_finished!
      else
        render "topics/index", alert: "Something went wrong"
      end
      if @post.save
        redirect_to contest_path(@contest), notice: "Thank you for playing."
      else
        render :new, alert: "Couldn't save your post"
      end
    else
      redirect_to topics_path, alert: "Something went wrong"
    end
  end

  def create_post
    @post = @contest.posts.new(post_params.merge(user: current_user))
    @name = @unfinished_contests.first.users.first.name.capitalize
    if @contest.aasm_state == "new"
      @contest.make_started!
    elsif @contest.aasm_state == "started"
      @contest.make_finished!
    end
    @post.save
    respond_to do |format|
      format.js
    end
  end

  private

  def set_unfinished_contests
    @unfinished_contests = Contest.started
  end

  def initiate_post
    @post = Post.new
  end

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def find_contest
    @contest = Contest.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:contest, :user, :content)
  end
end
