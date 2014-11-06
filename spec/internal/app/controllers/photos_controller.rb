class PhotosController < ActionController::Base
  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.create(photo_params)
    redirect_to @photo
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update photo_params
    redirect_to @photo
  end

  def destroy
    Photo.find(params[:id]).destroy!
    redirect_to photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :file)
  end
end
