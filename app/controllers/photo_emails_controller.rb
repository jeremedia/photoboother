class PhotoEmailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    email = PhotoEmail.create params[:photo_email]
    PhotoMailer.delay.photo_mail(params[:photo_email][:email], params[:photo_email][:photo_id])


  end


  private

    def user_params
      params.require(:photo_email).permit(:email,:photo_id)
    end




end
