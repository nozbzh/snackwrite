class Contest < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :users, through: :posts

  def finished?
    if self.status == "finished"
      return true
    else
      return false
    end
  end
end
