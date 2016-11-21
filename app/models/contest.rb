class Contest < ActiveRecord::Base
  include AASM

  has_many :posts, dependent: :destroy
  has_many :users, through: :posts
  has_many :votes
  has_many :voters, through: :votes, source: :user
  belongs_to :topic

  aasm do
    state :new, initial: true
    state :started
    state :finished

    event :make_started do
      transitions from: :new, to: :started
    end

    event :make_finished do
      transitions from: :started, to: :finished
    end
  end

  def self.find_for_vote(user)
    contest_ids_to_exclude = user.contests.finished.map(&:id).concat(user.voted_contests.map(&:id))
    contests = Contest.finished.where.not(id: contest_ids_to_exclude).includes(:votes)
    contest_and_votes = {}
    contests.each do |contest|
      contest_and_votes[contest.id] = contest.votes.count
    end
    if !contest_and_votes.empty?
      id = contest_and_votes.min_by{|k,v| v}[0]
      Contest.find(id)
    else
      nil
    end
  end

end
