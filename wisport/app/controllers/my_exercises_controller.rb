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

  # GET /myExercises/1
  # GET /myExercises/1.xml
  def show
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exercise }
    end
  end

  # GET /myExercises/new
  # GET /myExercises/new.xml
  def new
    @myExercises = Exercise.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @myExercises }
    end
  end

  # GET /myExercises/1/edit
  def edit
  end

  # POST /myExercises
  # POST /myExercises.xml
  def create
    @myExercises = myExercises.new(params[:myExercises])

    respond_to do |wants|
      if @myExercises.save
        flash[:notice] = 'myExercises was successfully created.'
        wants.html { redirect_to(@myExercises) }
        wants.xml  { render :xml => @myExercises, :status => :created, :location => @myExercises }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @myExercises.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /myExercises/1
  # PUT /myExercises/1.xml
  def update
    respond_to do |wants|
      if @likesExercise.update_attributes(params[:likesExercise])
        flash[:notice] = 'LikesExercise was successfully updated.'
        wants.html { redirect_to(@likesExercise) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @likesExercise.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /likesExercises/1
  # DELETE /likesExercises/1.xml
  def destroy
    @likesExercise.destroy

    respond_to do |wants|
      wants.html { redirect_to(likesExercises_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_likesExercise
      @likesExercise = LikesExercise.find(params[:id])
    end

end
