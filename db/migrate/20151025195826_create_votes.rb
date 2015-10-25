class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references  :user, index: true
      t.references  :contest, index: true
    end
  end
end
