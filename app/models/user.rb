class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :contests, through: :posts
  has_many :votes
  has_many :voted_contests, through: :votes, source: :contest
  has_many :votes_in_favor, through: :posts, source: :vote

  def to_s
    name.capitalize
  end

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
    votes.where(contest: contest).first.post.user.to_s
  end

  def voted_at(contest)
    votes.where(contest: contest).first.created_at.strftime("%b %-d %Y at %I:%M %P")
  end

  def total_votes_for(contest)
    contest.posts.where(user: self).first.votes.count
  end

  def total_votes
    posts.includes(:votes).map{|post|post.votes.count}.inject(:+)
  end

  # NEEDS REFACTOR!
  def self.most_popular
    most_popular = []
    User.all.includes(:posts).each do |user|
      most_popular << [user.total_votes, user.id]
    end
    # limit to 20 for now
    ids = most_popular.sort.reverse.map{|tuple| tuple[1]}.first(20)
    users_by_id = User.find(ids).index_by(&:id)
    users = ids.map{|id| users_by_id[id]}
  end
end
