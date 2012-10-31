class UserLoginServicesController < ApplicationController
  # GET /user_login_services
  # GET /user_login_services.json
  def index
    @user_login_services = UserLoginService.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_login_services }
    end
  end

  # GET /user_login_services/1
  # GET /user_login_services/1.json
  def show
    @user_login_service = UserLoginService.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_login_service }
    end
  end

  # GET /user_login_services/new
  # GET /user_login_services/new.json
  def new
    @user_login_service = UserLoginService.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_login_service }
    end
  end

  # GET /user_login_services/1/edit
  def edit
    @user_login_service = UserLoginService.find(params[:id])
  end

  # POST /user_login_services
  # POST /user_login_services.json
  def create
    @user_login_service = UserLoginService.new(params[:user_login_service])

    respond_to do |format|
      if @user_login_service.save
        format.html { redirect_to @user_login_service, notice: 'User login service was successfully created.' }
        format.json { render json: @user_login_service, status: :created, location: @user_login_service }
      else
        format.html { render action: "new" }
        format.json { render json: @user_login_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_login_services/1
  # PUT /user_login_services/1.json
  def update
    @user_login_service = UserLoginService.find(params[:id])

    respond_to do |format|
      if @user_login_service.update_attributes(params[:user_login_service])
        format.html { redirect_to @user_login_service, notice: 'User login service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_login_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_login_services/1
  # DELETE /user_login_services/1.json
  def destroy
    @user_login_service = UserLoginService.find(params[:id])
    @user_login_service.destroy

    respond_to do |format|
      format.html { redirect_to user_login_services_url }
      format.json { head :no_content }
    end
  end
end
