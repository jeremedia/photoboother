class Photo < ActiveRecord::Base
  
  
  mount_uploader :file, PhotofileUploader
  
  belongs_to :event
  
  
end
