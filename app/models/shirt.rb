class Shirt < ApplicationRecord
  validates_presence_of :jahr
  validates_presence_of :photo
  # Paperclip
  has_attached_file :photo, 
      :preserve_files => :false,
      :storage => :database, ## to save in database
      :url => '/shirts/show_photo/:id/:style',
      :styles => {
        :thumb => ['300x420#', :png],
        :show => ['500x700#', :png],
        :raster => ['100%', :png] 
        }
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/svg+xml"]
  
  def name
    return jahr.to_s + "_" + semester.to_s
  end
end
