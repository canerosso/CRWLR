class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  def root
    redirect_to home_path
  end

  def home
    if session[:user_id]
      @user = User.find(session[:user_id])
      redirect_to show_user_path(@user)
    end
  end

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    redirect_to login_path unless logged_in?
  end

end
