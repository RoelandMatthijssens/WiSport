class MySessionsController < ApplicationController

  def index
		@trainings_sessions = TrainingsSession.liked_by(current_user.id).search_by_title(params[:search_title]).search_by_owner(params[:search_owner]).search_by_description_and_exercise(params[:search_description]).published
			.concat(TrainingsSession.owned_by(current_user.id).search_by_title(params[:search_title]).search_by_owner(params[:search_owner]).search_by_description_and_exercise(params[:search_description]).published)
			.concat(TrainingsSession.owned_by(current_user.id).search_by_title(params[:search_title]).search_by_owner(params[:search_owner]).search_by_description_and_exercise(params[:search_description]).unpublished)
			.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trainings_sessions }
			format.js
    end
  end

end
