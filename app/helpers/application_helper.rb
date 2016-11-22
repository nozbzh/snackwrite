module ApplicationHelper

  def show_votes_for(contest, user)
    name = user == current_user ? 'You' : user.to_s
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

  def link_for_read(contest)
    if contest
      link_to "read", contest_path(contest), class: "choice"
    else
      link_to "read", coming_soon_path, class: "choice"
    end
  end

  def coming_soon_message(user)
    if user.voted_contests.count == 0
      "There is no contest for you to vote on yet."
    else
      "You already voted on all finished contests."
    end
  end

end
