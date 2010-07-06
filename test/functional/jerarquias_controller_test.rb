require 'test_helper'

class JerarquiasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jerarquias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jerarquia" do
    assert_difference('Jerarquia.count') do
      post :create, :jerarquia => { }
    end

    assert_redirected_to jerarquia_path(assigns(:jerarquia))
  end

  test "should show jerarquia" do
    get :show, :id => jerarquias(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => jerarquias(:one).to_param
    assert_response :success
  end

  test "should update jerarquia" do
    put :update, :id => jerarquias(:one).to_param, :jerarquia => { }
    assert_redirected_to jerarquia_path(assigns(:jerarquia))
  end

  test "should destroy jerarquia" do
    assert_difference('Jerarquia.count', -1) do
      delete :destroy, :id => jerarquias(:one).to_param
    end

    assert_redirected_to jerarquias_path
  end
end
