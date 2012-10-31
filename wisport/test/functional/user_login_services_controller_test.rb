require 'test_helper'

class UserLoginServicesControllerTest < ActionController::TestCase
  setup do
    @user_login_service = user_login_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_login_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_login_service" do
    assert_difference('UserLoginService.count') do
      post :create, user_login_service: { acces_token: @user_login_service.acces_token, login: @user_login_service.login, provider: @user_login_service.provider, uid: @user_login_service.uid }
    end

    assert_redirected_to user_login_service_path(assigns(:user_login_service))
  end

  test "should show user_login_service" do
    get :show, id: @user_login_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_login_service
    assert_response :success
  end

  test "should update user_login_service" do
    put :update, id: @user_login_service, user_login_service: { acces_token: @user_login_service.acces_token, login: @user_login_service.login, provider: @user_login_service.provider, uid: @user_login_service.uid }
    assert_redirected_to user_login_service_path(assigns(:user_login_service))
  end

  test "should destroy user_login_service" do
    assert_difference('UserLoginService.count', -1) do
      delete :destroy, id: @user_login_service
    end

    assert_redirected_to user_login_services_path
  end
end
