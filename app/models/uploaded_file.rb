class UploadedFile < ActiveRecord::Base
  has_attached_file :audio,
                    :path => ":rails_root/public/:attachment/:basename.:extension",
                    :url => ":rails_root/public/:attachment/:basename.:extension"
  validates_attachment_presence :audio
  validates_attachment_content_type :audio, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ],
                                    :message => 'file must be of filetype .mp3'



end
