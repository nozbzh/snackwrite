class PagesController < ApplicationController
  before_action :authenticate_user!, only: :coming_soon

  def home
    @contest = Contest.find_for_vote(current_user) if current_user
  end
end
