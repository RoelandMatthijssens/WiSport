class SessionsController < ApplicationController
  def new
    respond_to do |format|
			format.html
			format.js
		end
  end

  def create
    if env["omniauth.auth"]
      user = User.from_omniauth(env["omniauth.auth"])
    else
      user = User.authenticate(params[:signin][:login], params[:signin][:password])
    end
    respond_to do |format|
      if user
        session[:user_id] = user.id
        format.html do 
          redirect_to_target_or_default root_url, :notice => "Logged in successfully."
        end
        format.js {render js: %(window.location.pathname='') }
      else
        flash.now[:alert] = "Invalid login or password."
        format.html {render action: "new"}
        format.js {render action: "new"}
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
