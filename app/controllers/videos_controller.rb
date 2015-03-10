class VideosController < ApplicationController
  def index
    @videos = Video.order('created_at DESC')
    @style = params[:selected]
#    @selectstyle = params[:name]

    #putting the filter into the database..
#    @filters = Filter.new
    @stylefilter = Filter.last.name
  end

  def new
# @video = Video.new
  
  end

  def create
    @filters = Filter.new(params[:filters])
      if @filters.save
        flash[:success] = "Category changed to #{Filter.last.name}!"
        redirect_to root_url
      else
        flash[:error] = "Did not change to #{@stylefilter}!"
        redirect_to root_url
      end
#    @video = Video.new(params[:video])
#    if @video.save
#      flash[:success] = 'Video added!'
#      redirect_to root_url
#    else
#      render 'new'
#    end
  end
end