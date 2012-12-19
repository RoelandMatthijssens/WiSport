class DoSessionsController < ApplicationController
	before_filter :login_required
  # GET /do_sessions
  # GET /do_sessions.json
  def index
    @do_sessions = DoSession.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @do_sessions }
    end
  end

  # GET /do_sessions/1
  # GET /do_sessions/1.json
  def show
    @do_session = DoSession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @do_session }
    end
  end

  # GET /do_sessions/new
  # GET /do_sessions/new.json
  def new
    @do_session = DoSession.new(params[:do_session])
		TrainingsSession.find(params[:do_session][:trainings_session_id]).exercises.each do |ex|
			@do_session.do_exercises << DoExercise.new(exercise_id: ex.id, user_id: params[:do_session][:user_id],
				distance: ex.distance, hours: ex.distance, minutes: ex.minutes, reps: ex.reps, seconds: ex.seconds)
		end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @do_session }
			format.js
    end
  end

  # GET /do_sessions/1/edit
  def edit
    @do_session = DoSession.find(params[:id])
  end

  # POST /do_sessions
  # POST /do_sessions.json
  def create
    @do_session = DoSession.new(params[:do_session])
		#@do_session.trainings_session

    respond_to do |format|
      if @do_session.save
        format.html { redirect_to @do_session, notice: 'Do session was successfully created.' }
        format.json { render json: @do_session, status: :created, location: @do_session }
				format.js { render js: %(window.location='#{trainings_session_path(@do_session.trainings_session)}') }
      else
        format.html { render action: "new" }
        format.json { render json: @do_session.errors, status: :unprocessable_entity }
				format.js { render action: "new"}
      end
    end
  end

  # PUT /do_sessions/1
  # PUT /do_sessions/1.json
  def update
    @do_session = DoSession.find(params[:id])

    respond_to do |format|
      if @do_session.update_attributes(params[:do_session])
        format.html { redirect_to @do_session, notice: 'Do session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @do_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /do_sessions/1
  # DELETE /do_sessions/1.json
  def destroy
    @do_session = DoSession.find(params[:id])
    @do_session.destroy

    respond_to do |format|
      format.html { redirect_to do_sessions_url }
      format.json { head :no_content }
    end
  end
end
