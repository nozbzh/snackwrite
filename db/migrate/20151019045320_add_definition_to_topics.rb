class AddDefinitionToTopics < ActiveRecord::Migration
  def change
      add_column :topics, :definition, :string
  end
end
