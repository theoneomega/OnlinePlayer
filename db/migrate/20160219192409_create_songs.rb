class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :path
      t.integer :played

      t.timestamps null: false
    end
  end
end
