class EventsController < ApplicationController
	before_filter :login_required, :except => [:show ]
  # GET /events
  # GET /events.json
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @first_day_of_week = 1
    @event_strips = current_user.events.event_strips_for_month(@shown_month, @first_day_of_week)
		@forecast = HTTParty.get("http://api.wunderground.com/api/7aeb11b8b6f1a700/forecast10day/geolookup/q/autoip.json")
		unless @forecast && @forecast['forecast'] && @forecast['forecast']['simpleforecast'] && @forecast['forecast']['simpleforecast']['forecastday']
			ip = HTTParty.get("http://api.ipinfodb.com/v3/ip-city/?key=419418c11c5a24c908bd6c5f2acfe4886e7b0e26762bcf1386fdf0f0bcec39b1&ip=#{request.remote_ip}0&format=json")
			@forecast = HTTParty.get("http://api.wunderground.com/api/7aeb11b8b6f1a700/forecast10day/geolookup/q/#{ip["latitude"]},#{ip["longitude"]}.json")
			unless @forecast && @forecast['forecast'] && @forecast['forecast']['simpleforecast'] && @forecast['forecast']['simpleforecast']['forecastday']
				@forecast = HTTParty.get("http://api.wunderground.com/api/7aeb11b8b6f1a700/forecast10day/geolookup/q/Belgium/Brussels.json")
			end
		end 
		respond_to do |format|
      format.html # show.html.erb
      format.json { render json: Event.all }
    end
  end

	def nearby
		
		if params["latitude"] && params["longitude"] 
			define_map_markers [params["latitude"], params["longitude"]]
		elsif params["search_name"]
			define_map_markers params["search_name"]
		elsif request.location.latitude == 0 && request.location.longitude == 0
			define_map_markers "brussels, belgium"
		else
			my_loc = request.location
			define_map_markers
			logger.debug "AAAAAAAA #{my_loc.inspect}"
			define_map_markers [my_loc.latitude, my_loc.longitude]
		end
		@forecast = HTTParty.get("http://api.wunderground.com/api/7aeb11b8b6f1a700/forecast10day/geolookup/q/autoip.json")
		unless @forecast && @forecast['forecast'] && @forecast['forecast']['simpleforecast'] && @forecast['forecast']['simpleforecast']['forecastday']
			ip = HTTParty.get("http://api.ipinfodb.com/v3/ip-city/?key=419418c11c5a24c908bd6c5f2acfe4886e7b0e26762bcf1386fdf0f0bcec39b1&ip=#{request.remote_ip}0&format=json")
			@forecast = HTTParty.get("http://api.wunderground.com/api/7aeb11b8b6f1a700/forecast10day/geolookup/q/#{ip["latitude"]},#{ip["longitude"]}.json")
			unless @forecast && @forecast['forecast'] && @forecast['forecast']['simpleforecast'] && @forecast['forecast']['simpleforecast']['forecastday']
				@forecast = HTTParty.get("http://api.wunderground.com/api/7aeb11b8b6f1a700/forecast10day/geolookup/q/Belgium/Brussels.json")
			end
		end 
		respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @markers }
			format.js
    end
  end

	def define_map_markers qry
		if qry.class == Array
			@lat = qry[0]
			@long = qry[1]
		else
			r = Geocoder.search("Brussels, belgium")[0]
			@lat = r.latitude
			@long = r.longitude
		end
		@markers = Event.where("start_at > ?", Time.now).near(qry, 15).to_gmaps4rails do |event, marker|
			marker.infowindow render_to_string(:partial => "/events/maps_marker", :locals => { :event => event})
		end
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
		@my_sessions = TrainingsSession.liked_by(current_user.id).published
			.concat(TrainingsSession.owned_by(current_user.id).published)
			.concat(TrainingsSession.owned_by(current_user.id).unpublished)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
      format.js
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
		@my_sessions = TrainingsSession.liked_by(current_user.id).published
			.concat(TrainingsSession.owned_by(current_user.id).published)
			.concat(TrainingsSession.owned_by(current_user.id).unpublished)
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
		@event.user = current_user
		@event.visibility = "Published"
		@event.end_at = @event.start_at
		@my_sessions = TrainingsSession.liked_by(current_user.id).published
			.concat(TrainingsSession.owned_by(current_user.id).published)
			.concat(TrainingsSession.owned_by(current_user.id).unpublished)
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
		@my_sessions = TrainingsSession.liked_by(current_user.id).published
			.concat(TrainingsSession.owned_by(current_user.id).published)
			.concat(TrainingsSession.owned_by(current_user.id).unpublished)
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
