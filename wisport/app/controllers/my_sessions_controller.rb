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

  def show
    @trainings_session = TrainingsSession.find(params[:id])
		@exercise_list = @trainings_session.exercises.paginate(:page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trainings_session }
    end
  end

  def new
    @trainings_session = TrainingsSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trainings_session }
			format.js
    end
  end

  def edit
    @trainings_session = TrainingsSession.find(params[:id])
  end

  def create
    @trainings_session = TrainingsSession.new(params[:trainings_session])
		@trainings_session.visibility = "Private"
		@trainings_session.owner = current_user if current_user

    respond_to do |format|
      if @trainings_session.save
        format.html { redirect_to @trainings_session, notice: 'Trainings session was successfully created.' }
        format.json { render json: @trainings_session, status: :created, location: @trainings_session }
				format.js { render js: %(window.location='#{trainings_sessions_path}') }
      else
        format.html { render action: "new" }
        format.json { render json: @trainings_session.errors, status: :unprocessable_entity }
				format.js { render action: "new"}
      end
    end
  end

  def update
    @trainings_session = TrainingsSession.find(params[:id])

    respond_to do |format|
      if @trainings_session.update_attributes(params[:trainings_session])
        format.html { redirect_to @trainings_session, notice: 'Trainings session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trainings_session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @trainings_session = TrainingsSession.find(params[:id])
    @trainings_session.destroy

    respond_to do |format|
      format.html { redirect_to trainings_sessions_url }
      format.json { head :no_content }
    end
  end
end
