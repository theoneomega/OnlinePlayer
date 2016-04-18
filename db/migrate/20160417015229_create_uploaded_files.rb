class CreateUploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.string :audio

      t.timestamps null: false
    end
  end
end
