class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :word
      t.integer :time_limit
      t.string :status
      t.timestamps null: false
    end
  end
end
