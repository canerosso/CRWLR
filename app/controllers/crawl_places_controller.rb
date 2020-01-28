class CrawlPlacesController < ApplicationController
  def new
    @crawl = Crawl.find(params[:id])
    # @place = Place.new
  end

  def create
    @crawl = Crawl.find(params[:id])
    new_place = CrawlPlace.new(crawl_place_params)
    if new_place.save
      redirect_to show_crawl_path(@crawl)
    else
      flash[:errors] = new_place.errors.full_messages
      render :search_results
    end
  end

  def destroy
    crawl_place = CrawlPlace.find_by(crawl_id: params[:crawl_place][:crawl_id], place_id: params[:crawl_place][:place_id])
    crawl_place.destroy
    redirect_to show_crawl_path(params[:crawl_place][:crawl_id])
  end

  def type_select
    @crawl = Crawl.find(params[:crawl_id])
    @types = ["Restaurant", "Bar"]
    @search = []
  end

  def category_select
    @crawl = Crawl.find(params[:crawl_id])
    @type = params[:type]
    @duration = params[:duration]
    if @type == "Restaurant"
      @categories = Place.restaurant_categories
    else
      @categories = Place.bar_categories
    end
  end

  def search_results
    @crawl = Crawl.find(params[:crawl_id])
    @duration = params[:duration]
    # @crawl = Crawl.find(params[:crawl_place][:crawl_id])
    @categories = params[:category]
    results = Place.search(@categories)
    if @crawl.places.last
      @last_place = @crawl.places.last
    else
      @last_place = [36.1147, 115.1728]
    end
    @sorted_results = Place.sort_by_distance(results, @last_place)
  end

  private
  def crawl_place_params
    params.require(:crawl_place).permit(:crawl_id, :place_id, :duration)
  end
end