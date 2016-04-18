class AddAttachmentSongToAudioFiles < ActiveRecord::Migration
  def self.up
    change_table :audio_files do |t|
      t.attachment :song
    end
  end

  def self.down
    remove_attachment :audio_files, :song
  end
end
