class PostsController < ApplicationController
  before_action :find_contest, only: :create

  def create
    @post = @contest.posts.build(post_params)
    @post.user = current_user
    # make @contest.status = half-complete if @contest.posts.size < 1
    # make @contest.status = complete if @contest.posts.size > 0
    if @post.save
      redirect_to root_path #contest show
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
