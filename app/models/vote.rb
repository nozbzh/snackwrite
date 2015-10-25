class Vote < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  belongs_to :post
end
