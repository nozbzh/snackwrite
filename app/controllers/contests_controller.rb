class ContestsController < ApplicationController
  before_action :find_contest, only: [:show, :continue_contest, :create_post]
  before_action :set_user
  before_action :find_topic, only: :new
  before_action :initiate_post, only: [:new, :continue_contest]
  before_action :set_unfinished_contests, only: [:new, :continue_contest]

  def index
    @contests = Contest.all.where(aasm_state: :finished).order("updated_at DESC")
  end

  def new
    @contest = Contest.new
    @contest.topic = @topic
    @contest.save
    @unplayable_contests = @unfinished_contests & @user.contests
  end

  def create_post
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
      raise "cannot la"
      #render "contests/index"
    end
  end

  def continue_contest
  end

  def show
  end

  private

  def set_unfinished_contests
    @unfinished_contests = Contest.all.where(aasm_state: :started)
  end

  def initiate_post
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

  def post_params
    params.require(:post).permit(:contest, :user, :content)
  end
end
