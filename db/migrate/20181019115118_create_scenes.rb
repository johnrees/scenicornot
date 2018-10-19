# frozen_string_literal: true

class CreateScenes < ActiveRecord::Migration[5.2]
  def change
    create_table :scenes do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.integer :average_int
      t.integer :variance_int
      t.integer :votes, array: true, default: []
      t.integer :num_votes, default: 0
      t.text :geograph_uri
      t.text :src
      t.jsonb :data, default: {}

      t.timestamps
    end
    add_index :scenes, %i[latitude longitude]
    add_index :scenes, %i[average_int num_votes]
    add_index :scenes, :variance_int
  end
end
