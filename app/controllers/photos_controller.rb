class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
skip_before_filter :verify_authenticity_token, only: [:import]
  def import
    
    
    path = params[:path]
    parts = path.split("events")[1].split("/")
    
    event_name = parts[1]
    version = parts[2]
    file_name = parts[3]
    
    
    
    photo = Event.where(name:event_name).first.photos.new
    
    if path.include?("tmp")
      render :text=>"ignored temp file"
    else
      
      if version == ("originals")
        
        ActionCable.server.broadcast 'messages',
          thumbUrl: "",
          bigUrl: "",
          photo: "",
          message: "New Photo Processing..."
        
        logger.debug(path )
        logger.debug(Rails.root.to_s + "/photoboother.workflow")
        
        path2 = Shellwords.escape( path )
        processed_path = Rails.public_path + "events/#{event_name}/processed"
        
        `automator -i #{path2} -D processed_path=#{processed_path} #{Rails.root.to_s + "/photoboother.workflow"}`
        
        render :text=>"Hid Big Photo"
        
      elsif path.include?("processed")
      
        File.open(path) do |f|
          photo.file = f
        end
    
        photo.save!
    
        ActionCable.server.broadcast 'messages',
          thumbUrl: photo.file.thumb.url,
          bigUrl: photo.file.big.url,
          photo: photo.id

        render :text=>"Processed photo to: " + photo.file.current_path
        
      end
            
    end
  end
  
  
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:file)
    end
end
