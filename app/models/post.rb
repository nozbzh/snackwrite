class Post < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  has_many :votes

  #has_reputation :votes, source: :user, aggregated_by: :sum
end
