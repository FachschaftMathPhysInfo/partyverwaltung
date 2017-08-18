class Shirt < ApplicationRecord
  validates_presence_of :jahr
  validates_presence_of :photo
  # Paperclip
  has_attached_file :photo, 
      :preserve_files => :false,
      :styles => {
        :thumb => ['300x420#', :png],
        :show => ['500x700#', :png],
        :raster => ['100%', :png] 
        }
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/svg+xml"]
end
