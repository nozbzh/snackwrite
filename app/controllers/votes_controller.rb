class VotesController < ApplicationController
  before_action :find_contest, only: :create
  before_action :authenticate_user!

  respond_to :js

  def create
    @vote = @contest.votes.new(vote_params.merge(user: current_user))
    if @vote.save
      @message = "You voted for #{@vote.post.user.name.capitalize}"
    end
  end

  private

  def find_contest
    @contest = Contest.find(params[:id])
  end

  def vote_params
    params.permit(:post_id)
  end
end
