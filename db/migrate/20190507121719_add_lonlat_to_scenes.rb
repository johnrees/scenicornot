class AddLonlatToScenes < ActiveRecord::Migration[5.2]
  def change
    add_column :scenes, :lonlat, :st_point, geographic: true
    add_index :scenes, :lonlat, using: :gist
  end
end
