class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
  	@current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]   # stores the instance variable once and re hit of request is not made
  end

  def logged_in?
  	!!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "you must be logged in to perform the action"
      redirect_to :back
    end
  end

end
