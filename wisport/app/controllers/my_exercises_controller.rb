class MyExercisesController < ApplicationController
	before_filter :login_required
  # GET /myExercises
  # GET /myExercises.xml
  def index
		@exercises = Exercise.liked_by(current_user.id).search_by_name(params[:search_name]).search_by_type(params[:search_type]).published
			.concat(Exercise.owned_by(current_user.id).search_by_name(params[:search_name]).search_by_type(params[:search_type]).published)
			.concat(Exercise.owned_by(current_user.id).search_by_name(params[:search_name]).search_by_type(params[:search_type]).unpublished)
			.paginate(:page => params[:page], :per_page => 10)
			#Exercise.liked_by(current_user.id).published.paginate(:page => params[:page], :per_page => 30)
		logger.debug "wisport #{@exercises}"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exercises }
			format.js
    end
  end

end
