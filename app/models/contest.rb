class Contest < ActiveRecord::Base
  include AASM

  has_many :posts, dependent: :destroy
  has_many :users, through: :posts
  has_many :votes
  has_many :voters, through: :votes, source: :user
  belongs_to :topic
  #validates :posts, presence: true

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

end
