class VotesController < ApplicationController
  before_action :find_contest, only: :create
  before_action :authenticate_user!, except: :index

  respond_to :js

  def create
    @vote = @contest.votes.new(vote_params.merge(user: current_user))
    @vote.save
    @next_contest = Contest.find_for_vote(current_user)
  end

  private

  def find_contest
    @contest = Contest.find(params[:id])
  end

  def vote_params
    params.permit(:post_id)
  end
end
