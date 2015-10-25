class PostsController < ApplicationController
  before_action :find_contest, only: :create

  def create
    @post = @contest.posts.build(post_params.merge(user: current_user))
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
      raise
      #render "contests/index"
    end
  end

  private

  def post_params
    params.require(:post).permit(:contest, :user, :content)
  end

  def find_contest
    @contest = Contest.find(params[:id])
  end

end
