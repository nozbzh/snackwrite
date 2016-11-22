class Vote < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  belongs_to :post
  has_one :chosen_user, through: :post, source: :user
end
