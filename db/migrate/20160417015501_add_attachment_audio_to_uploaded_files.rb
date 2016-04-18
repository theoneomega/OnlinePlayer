class AddAttachmentAudioToUploadedFiles < ActiveRecord::Migration
  def self.up
    change_table :uploaded_files do |t|
      t.attachment :audio
    end
  end

  def self.down
    remove_attachment :uploaded_files, :audio
  end
end
