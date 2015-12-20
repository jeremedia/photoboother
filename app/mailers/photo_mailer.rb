class PhotoMailer < ApplicationMailer
  default from: 'j@jeremedia.com'
  
  def photo_mail(email, photo_id)
      @email = email
      @photo = Photo.find(photo_id)
      attachments.inline['photobooth_photo.jpg'] = File.read(@photo.file.big.path)
      
      mail(to: @email, subject: 'Your photobooth photo.')
    end
    
  
end
