class CrawlsController < ApplicationController
  before_action :authorized, only: [:show]
  
  def new
    @crawl = Crawl.new
  end

  def create
    @crawl = Crawl.new(crawl_params)
    @crawl.host = current_user
    @crawl.save
    redirect_to show_user_path(@crawl.host)
  end

  def show
    @crawl = Crawl.find(params[:id])
    @places = @crawl.places
    @crawl_places = CrawlPlace.where(crawl_id: @crawl.id)
    @guests = @crawl.guests
    @potential_invites = potential_invites(@crawl)
    @invite = Invite.new
    @invites = Invite.where(crawl_id: @crawl.id)
    @map_url = url_maker(@places)
  end

  def url_maker(places)
    url = "https://maps.googleapis.com/maps/api/staticmap?&size=500x300&maptype=roadmap"
    # &markers=label: index | lat , long
    places.each_with_index do |place, i|
      index = i + 1
      lat = place.latitude
      long = place.longitude
      url << "&markers=label:#{index}|#{lat},#{long}"
    end
    url << "&key=#{ENV["GOOGLE_MAPS_API_KEY"]}"
    #https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=YOUR_API_KEY
  end

  def invite
    
  end

  private

  def crawl_params
    params.require(:crawl).permit(:name, :location, :duration, :date)
  end

  def potential_invites(crawl)
    users = User.all
    #byebug
    without_host = users.excluding(crawl.host)
    without_curr_invites = without_host.excluding(crawl.guests)
  end

end
