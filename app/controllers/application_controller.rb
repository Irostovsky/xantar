class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def go_to path
    if request.xhr?
      render :js => "window.location = '#{path}'"
    else
      redirect_to path
    end
  end

end
