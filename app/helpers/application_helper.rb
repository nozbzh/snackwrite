module ApplicationHelper

  def show_votes_for(contest, user)
    name = user == current_user ? 'You' : user.name.capitalize
    first_words = name == 'You' ? "You have" : "#{name} has"
    "#{first_words} #{pluralize(user.total_votes_for(contest), 'vote')}."
  end

  def vote_message(contest)
    if current_user.has_voted?(contest)
      "You voted for #{current_user.voted_for(contest)} on #{current_user.voted_at(contest)}."
    elsif current_user.is_participant?(contest)
      "You participated in this contest, you cannot vote."
    end
  end
end
