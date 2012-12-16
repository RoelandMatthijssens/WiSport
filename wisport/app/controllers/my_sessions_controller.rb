class MySessionsController < ApplicationController

  def index
		@trainings_sessions = TrainingsSession.all
    @my_published_sessions = TrainingsSession.owned_by(current_user.id).published.paginate(:page => params["my_pup_ex"])
		@my_unpublished_sessions = TrainingsSession.owned_by(current_user.id).unpublished.paginate(:page => params["my_unpup_ex"])
		@my_likes_sessions = TrainingsSession.liked_by(current_user.id).published.paginate(:page => params["my_like_ex"])
		
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trainings_sessions }
    end
  end

end
