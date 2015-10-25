class AddTopicKeyToContests < ActiveRecord::Migration
  def change
    remove_column :contests, :word, :string
    add_reference :contests, :topic, index: true
  end
end
