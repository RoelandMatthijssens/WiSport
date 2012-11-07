class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

	def index
		@users = User.all
	end
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end

	def follow
		@user = User.find_by_id(params[:id])
		@user.friends << @current_user unless @user.friends.include? @current_user
		respond_to do |format|
			format.html
			format.js
		end
	end
	def unfollow
		@user = User.find_by_id(params[:id])
		@user.friends.delete(@current_user) if @user.friends.include? @current_user
		respond_to do |format|
			format.html
			format.js
		end
	end
end
