class EventsController < ApplicationController
	before_filter :login_required
  # GET /events
  # GET /events.json
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @first_day_of_week = 1
    @event_strips = current_user.events.event_strips_for_month(@shown_month, @first_day_of_week)
		@forecast = HTTParty.get("http://api.wunderground.com/api/7aeb11b8b6f1a700/forecast10day/geolookup/q/autoip.json")
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
		@json = @event.to_gmaps4rails

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
		@event.start_at = Time.now
		@event.end_at = Time.now
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
      format.js
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
		@event.user = current_user
		@event.visibility = "Published"
		@event.end_at = @event.start_at
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
        format.js { render js: %(window.location='#{events_path}') }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js { render action: "new"}
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event= Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
				@event.end_at = @event.start_at
				@event.save!
        format.html { redirect_to events_path, notice: 'event was successfully updated.' }
        format.json { head :no_content }
        format.js { render js: %(window.location='#{events_path}') }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js { render action: "edit"}
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to event_url }
      format.json { head :no_content }
			format.js
    end
  end

	def publish
		@event = Exercise.find_by_id(params[:id])
		logger.debug(@event.visibility)
		if @event.visibility=="Private"
			@event.visibility = "Published"
		else
			@event.visibility = "Private"
		end
		@event.save
		respond_to do |format|
			format.html
			format.js
		end
	end
end
