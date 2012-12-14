class TrainingsSessionsController < ApplicationController
  # GET /trainings_sessions
  # GET /trainings_sessions.json
  def index
    @trainings_sessions = TrainingsSession.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trainings_sessions }
    end
  end

  # GET /trainings_sessions/1
  # GET /trainings_sessions/1.json
  def show
    @trainings_session = TrainingsSession.find(params[:id])
		@exercise_list = @trainings_session.exercises.paginate(:page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trainings_session }
    end
  end

  # GET /trainings_sessions/new
  # GET /trainings_sessions/new.json
  def new
    @trainings_session = TrainingsSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trainings_session }
			format.js
    end
  end

  # GET /trainings_sessions/1/edit
  def edit
    @trainings_session = TrainingsSession.find(params[:id])
  end

  # POST /trainings_sessions
  # POST /trainings_sessions.json
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

  # PUT /trainings_sessions/1
  # PUT /trainings_sessions/1.json
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

  # DELETE /trainings_sessions/1
  # DELETE /trainings_sessions/1.json
  def destroy
    @trainings_session = TrainingsSession.find(params[:id])
    @trainings_session.destroy

    respond_to do |format|
      format.html { redirect_to trainings_sessions_url }
      format.json { head :no_content }
    end
  end
end
