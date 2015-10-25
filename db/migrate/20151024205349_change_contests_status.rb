class ChangeContestsStatus < ActiveRecord::Migration
  def change
    remove_column :contests, :status, :string
    add_column :contests, :aasm_state, :string
  end
end
