class AddLocalAuthorityFieldsToScenes < ActiveRecord::Migration[5.2]
  def change
    add_column :scenes, :lad17cd, :text
    add_column :scenes, :lad17nm, :text
  end
end
