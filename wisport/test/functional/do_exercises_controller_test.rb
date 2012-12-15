require 'test_helper'

class DoExercisesControllerTest < ActionController::TestCase
  setup do
    @do_exercise = do_exercises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:do_exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create do_exercise" do
    assert_difference('DoExercise.count') do
      post :create, do_exercise: { distance: @do_exercise.distance, hours: @do_exercise.hours, minutes: @do_exercise.minutes, reps: @do_exercise.reps, seconds: @do_exercise.seconds, visibility: @do_exercise.visibility }
    end

    assert_redirected_to do_exercise_path(assigns(:do_exercise))
  end

  test "should show do_exercise" do
    get :show, id: @do_exercise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @do_exercise
    assert_response :success
  end

  test "should update do_exercise" do
    put :update, id: @do_exercise, do_exercise: { distance: @do_exercise.distance, hours: @do_exercise.hours, minutes: @do_exercise.minutes, reps: @do_exercise.reps, seconds: @do_exercise.seconds, visibility: @do_exercise.visibility }
    assert_redirected_to do_exercise_path(assigns(:do_exercise))
  end

  test "should destroy do_exercise" do
    assert_difference('DoExercise.count', -1) do
      delete :destroy, id: @do_exercise
    end

    assert_redirected_to do_exercises_path
  end
end
