class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def require_log_in
    render json: {error: ["Must be logged in"]}, status: 401 unless logged_in?
  end

  def logout
    @current_user.reset_session_token!
    session[:session_token] = nil
  end

end
