class HomeController < ApplicationController
  before_filter :login_required

  before_action :set_auth

  def index
    
  end

  private

  def set_auth
  	@auth = session[:user_id] if session[:user_id]
  end
end
