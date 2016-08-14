class UserSessionsController < ApplicationController
  
  before_filter :login_required, only: [ :destroy ]

  #kupi podatke o useru iz hasha kojo dobija iz omniautha
  def create
    omniauth = request.env['omniauth.auth']

    user = User.find_by_uid(omniauth['uid'])
    if not user
      # registruje novog usera
      user = User.new(:uid => omniauth['uid'])
    end
    user.email = omniauth['info']['email']
    user.save

    # sve info o useru u sesiji
    session[:user_id] = omniauth

    flash[:notice] = "Successfully logged in"
    redirect_to root_path
  end

  # Omniauth failure callback
  def failure
    flash[:notice] = params[:message]
  end

  # logout - cisti sesiju i redirektuje na provajder log in opet
  def destroy
    session[:user_id] = nil

    flash[:notice] = 'You have successfully signed out!'
    redirect_to "#{CUSTOM_PROVIDER_URL}/users/sign_out"
  end
end
