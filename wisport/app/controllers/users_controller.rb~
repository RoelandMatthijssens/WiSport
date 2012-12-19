class UsersController < ApplicationController
	require 'will_paginate/array'
  before_filter :login_required, :except => [:new, :create]

	def index
		@users = User.search_by_name(params[:q])
		respond_to do |format|
			format.html
			format.js
			format.json { render json: @users.map { |u| {:id => u.id, :name => u.username} } }
		end
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
		@exercises = @user.exercises.paginate(:page => params[:my_exercises_page])
		@trainings_sessions = @user.trainings_sessions.paginate(:page => params[:my_sessions_page])
		@followers_exercises = @user.followers_exercises.paginate(:page => params[:followers_page])
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

	def toggle_follow
		@user = User.find_by_id(params[:id])
		if @current_user.friends.include? @user
			@current_user.friends.delete(@user)
		else
			@current_user.friends << @user
		end
		respond_to do |format|
			format.html
			format.js
		end
	end
end
