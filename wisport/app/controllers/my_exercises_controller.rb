class MyExercisesController < ApplicationController
  # GET /myExercises
  # GET /myExercises.xml
  def index
    @my_published_exercises = Exercise.owned_by(current_user.id).published.paginate(:page => params[:page])
		@my_unpublished_exercises = Exercise.owned_by(current_user.id).unpublished.paginate(:page => params[:page])
		@my_likes_exercises = Exercise.liked_by(current_user.id).published.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exercises }
    end
  end

end
