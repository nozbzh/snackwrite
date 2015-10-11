class Contest < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :users, through: :posts
end
