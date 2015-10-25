class AddPostsToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :post, index: true
  end
end
