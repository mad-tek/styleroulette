class VideosController < ApplicationController
  def index
    @style = params[:selected]
  end

  def new
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
  end
end