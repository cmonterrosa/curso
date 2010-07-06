require 'test_helper'

class PuestosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:puestos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create puesto" do
    assert_difference('Puesto.count') do
      post :create, :puesto => { }
    end

    assert_redirected_to puesto_path(assigns(:puesto))
  end

  test "should show puesto" do
    get :show, :id => puestos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => puestos(:one).to_param
    assert_response :success
  end

  test "should update puesto" do
    put :update, :id => puestos(:one).to_param, :puesto => { }
    assert_redirected_to puesto_path(assigns(:puesto))
  end

  test "should destroy puesto" do
    assert_difference('Puesto.count', -1) do
      delete :destroy, :id => puestos(:one).to_param
    end

    assert_redirected_to puestos_path
  end
end
