class PhotosController < ApplicationController

  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_flickr, only: [:show, :edit, :update, :create, :destroy]

  def index
    @photos = Photo.order('created_at DESC').paginate(page: params[:page], per_page: 4)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create

    photo_id = flickr.upload_photo watermark(params[:image].tempfile.path), title: params[:photo][:title], description: params[:photo][:description]
    photo_url = FlickRaw.url_o(flickr.photos.getInfo(photo_id: photo_id))

    @photo = Photo.new(photo_id: photo_id, photo_url: photo_url, title: params[:photo][:title], description: params[:photo][:description])

    if @photo.save
      flash[:success] = "Фото добавлено"
      redirect_to photos_url
    else
      render 'new'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

    if flickr.photos.setMeta photo_id: @photo.photo_id, title: params[:photo][:title], description: params[:photo][:description]
      @photo.update_attributes(title: params[:photo][:title], description: params[:photo][:description])
      flash[:success] = "Данные фото успешно обновлены"
      redirect_to photos_url
    else
      render 'edit'
    end
  end

  def destroy
    flickr.photos.delete(photo_id: @photo.photo_id)
    @photo.destroy
    flash[:success] = "Фото удалено"
    redirect_to photos_url
  end

  private

  def watermark(pic)
    img = Magick::Image.read(pic.to_s).first
    img = img.resize_to_fit!(2048, 1080)

    mark = Magick::Image.new(250, 100) {self.background_color = "none"}
    draw = Magick::Draw.new

    draw.annotate(mark, 0, 0, 0, 0, "rbk.kiev.ua") do
       draw.gravity = Magick::CenterGravity
       draw.pointsize = 36
       draw.font_family = "Times"
       draw.fill = "white"
       draw.stroke = "none" 
    end

    img_watermark = img.dissolve(mark, 0.25, 0.25, Magick::SouthEastGravity)
    img_watermark.write(pic.to_s) 
    return pic.to_s
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def set_flickr
    FlickRaw.api_key = ENV['FLICKR_API_KEY']
    FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']

    flickr.access_token = ENV['FLICKR_ACCESS_TOKEN']
    flickr.access_secret = ENV['FLICKR_ACCESS_SECRET']
  end

end
