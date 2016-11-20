class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :contests, through: :posts
  has_many :votes
  has_many :voted_contests, through: :votes, source: :contest

  def has_voted?(contest)
    voted_contests_ids = voted_contests.map(&:id)
    voted_contests_ids.include?(contest.id)
  end

  def is_participant?(contest)
    contests_ids = contests.map(&:id)
    contests_ids.include?(contest.id)
  end

  def can_vote?(contest)
    !has_voted?(contest) && !is_participant?(contest)
  end

  def voted_for(contest)
    votes.where(contest: contest).first.post.user.name.capitalize
  end

  def voted_at(contest)
    votes.where(contest: contest).first.created_at
  end
end
