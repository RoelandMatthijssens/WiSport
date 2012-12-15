require 'test_helper'

class DoSessionsControllerTest < ActionController::TestCase
  setup do
    @do_session = do_sessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:do_sessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create do_session" do
    assert_difference('DoSession.count') do
      post :create, do_session: { remarks: @do_session.remarks, visibility: @do_session.visibility }
    end

    assert_redirected_to do_session_path(assigns(:do_session))
  end

  test "should show do_session" do
    get :show, id: @do_session
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @do_session
    assert_response :success
  end

  test "should update do_session" do
    put :update, id: @do_session, do_session: { remarks: @do_session.remarks, visibility: @do_session.visibility }
    assert_redirected_to do_session_path(assigns(:do_session))
  end

  test "should destroy do_session" do
    assert_difference('DoSession.count', -1) do
      delete :destroy, id: @do_session
    end

    assert_redirected_to do_sessions_path
  end
end
