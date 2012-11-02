class SessionsController < ApplicationController
  def new
  end

  def create
    if env["omniauth.auth"]
      user = User.from_omniauth(env["omniauth.auth"])
    else
      user = User.authenticate(params[:signin][:login], params[:signin][:password])
    end
    respond_to do |format|
      if user
        format.html do 
          session[:user_id] = user.id
          redirect_to_target_or_default root_url, :notice => "Logged in successfully."
        end
        format.json do 
          session[:user_id] = user.id
          render json: user, status: :created, location: user 
        end
      else
        format.html do
          flash.now[:alert] = "Invalid login or password." 
          render action: "new" 
        end
        format.json { render json: "error", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
