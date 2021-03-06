class TrainingsSessionsController < ApplicationController
	before_filter :login_required, :except => [:index, :show ]
  # GET /trainings_sessions
  # GET /trainings_sessions.json
  def index
    @trainings_sessions = TrainingsSession
			.search_by_title(params[:search_title])
			.search_by_owner(params[:search_owner])
			.search_by_description_and_exercise(params[:search_description])
			.published.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trainings_sessions }
			format.js
    end
  end

  # GET /trainings_sessions/1
  # GET /trainings_sessions/1.json
  def show
    @trainings_session = TrainingsSession.find(params[:id])
		@exercise_list = @trainings_session.exercises.paginate(:page => params[:page])

		@graph_data = {}
		@trainings_session.exercises.each do |e|
			exercises = DoExercise.find(:all, :conditions => ["exercise_id=? and user_id=?", e.id, current_user.id])
			@graph_data[e.id] = exercises
		end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trainings_session }
    end
  end

  # GET /trainings_sessions/new
  # GET /trainings_sessions/new.json
  def new
    @trainings_session = TrainingsSession.new
		@my_exercises = Exercise.liked_by(current_user.id).published
			.concat(Exercise.owned_by(current_user.id).published)
			.concat(Exercise.owned_by(current_user.id).unpublished)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trainings_session }
			format.js
    end
  end

  # GET /trainings_sessions/1/edit
  def edit
    @trainings_session = TrainingsSession.find(params[:id])
		@my_exercises = Exercise.liked_by(current_user.id).published
			.concat(Exercise.owned_by(current_user.id).published)
			.concat(Exercise.owned_by(current_user.id).unpublished)
  end

  # POST /trainings_sessions
  # POST /trainings_sessions.json
  def create
    @trainings_session = TrainingsSession.new(params[:trainings_session])
		@trainings_session.owner = current_user if current_user
		@my_exercises = Exercise.liked_by(current_user.id).published
			.concat(Exercise.owned_by(current_user.id).published)
			.concat(Exercise.owned_by(current_user.id).unpublished)

    respond_to do |format|
      if @trainings_session.save
        format.html { redirect_to my_sessions_path, notice: 'Trainings session was successfully created.' }
        format.json { render json: @trainings_session, status: :created, location: @trainings_session }
				format.js
      else
        format.html { render action: "new" }
        format.json { render json: @trainings_session.errors, status: :unprocessable_entity }
				format.js { render action: "new"}
      end
    end
  end

  # PUT /trainings_sessions/1
  # PUT /trainings_sessions/1.json
  def update
    @trainings_session = TrainingsSession.find(params[:id])
		@my_exercises = Exercise.liked_by(current_user.id).published
			.concat(Exercise.owned_by(current_user.id).published)
			.concat(Exercise.owned_by(current_user.id).unpublished)

    respond_to do |format|
      if @trainings_session.update_attributes(params[:trainings_session])
        format.html { redirect_to @trainings_session, notice: 'Trainings session was successfully updated.' }
        format.json { head :no_content }
				format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @trainings_session.errors, status: :unprocessable_entity }
				format.js { render action: "edit"}
      end
    end
  end

  # DELETE /trainings_sessions/1
  # DELETE /trainings_sessions/1.json
  def destroy
    @trainings_session = TrainingsSession.find(params[:id])
    @trainings_session.destroy

    respond_to do |format|
      format.html { redirect_to trainings_sessions_url }
      format.json { head :no_content }
			format.js
    end
  end

	def publish
		@trainings_session = TrainingsSession.find_by_id(params[:id])
		logger.debug(@trainings_session.visibility)
		if @trainings_session.visibility=="Private"
			@trainings_session.visibility = "Published"
		else
			@trainings_session.visibility = "Private"
		end
		@trainings_session.save
		respond_to do |format|
			format.html
			format.js
		end
	end
	
end
