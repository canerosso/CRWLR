class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_crawls = @user.hosted_crawls
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def invites
    @invites = Invite.where(user_id: current_user)
    @invited_crawls = @invites.map do |invite|
      Crawl.where(id: invite.crawl_id)
    end
    @invited_crawls.flatten!
    @places = @invited_crawls.map do |crawl|
      crawl.places
    end
    #byebug
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :password, :password_confirmation)
  end

end
