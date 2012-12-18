class DoExercisesController < ApplicationController
	before_filter :login_required
  # GET /do_exercises
  # GET /do_exercises.json
  def index
    @do_exercises = DoExercise.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @do_exercises }
    end
  end

  # GET /do_exercises/1
  # GET /do_exercises/1.json
  def show
    @do_exercise = DoExercise.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @do_exercise }
    end
  end

  # GET /do_exercises/new
  # GET /do_exercises/new.json
  def new
    @do_exercise = DoExercise.new(params[:do_exercise])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @do_exercise }
    end
  end

  # GET /do_exercises/1/edit
  def edit
    @do_exercise = DoExercise.find(params[:id])
  end

  # POST /do_exercises
  # POST /do_exercises.json
  def create
    @do_exercise = DoExercise.new(params[:do_exercise])

    respond_to do |format|
      if @do_exercise.save
        format.html { redirect_to @do_exercise, notice: 'Do exercise was successfully created.' }
        format.json { render json: @do_exercise, status: :created, location: @do_exercise }
      else
        format.html { render action: "new" }
        format.json { render json: @do_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /do_exercises/1
  # PUT /do_exercises/1.json
  def update
    @do_exercise = DoExercise.find(params[:id])

    respond_to do |format|
      if @do_exercise.update_attributes(params[:do_exercise])
        format.html { redirect_to @do_exercise, notice: 'Do exercise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @do_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /do_exercises/1
  # DELETE /do_exercises/1.json
  def destroy
    @do_exercise = DoExercise.find(params[:id])
    @do_exercise.destroy

    respond_to do |format|
      format.html { redirect_to do_exercises_url }
      format.json { head :no_content }
    end
  end
end
