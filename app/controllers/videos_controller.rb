class VideosController < ApplicationController

  def index 
    @videos = Video.order('created_at DESC').paginate(page: params[:page], per_page: 4)
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "Видео добавлено"
      redirect_to videos_url
    else
      render 'new'
    end
  end

  def destroy
    Video.find(params[:id]).destroy
     flash[:success] = "Видео удалено"
     redirect_to videos_url
  end

  private                                
                                         
  def video_params                       
    params.require(:video).permit(:video_url) 
  end                                    

end
