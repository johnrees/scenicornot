class AddLabelsDataToScenes < ActiveRecord::Migration[5.2]
  def change
    add_column :scenes, :labels_data, :jsonb
  end
end
