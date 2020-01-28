class InvitesController < ApplicationController
    def create
        @invite = Invite.new(invite_params)
        @invite.save
        #byebug
        redirect_to show_crawl_path(@invite.crawl)
    end

    def delete
        @invite = Invite.find(params[:id])
        @crawl = @invite.crawl
        @invite.destroy
        redirect_to show_crawl_path(@crawl) 
    end

    private

    def invite_params
        params.require(:invite).permit(:user_id, :crawl_id)
    end
end