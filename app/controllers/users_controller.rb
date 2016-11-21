class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show
    @contest = @user.contests.includes(:posts)
    @voted_contests = @user.voted_contests.includes(:votes)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
