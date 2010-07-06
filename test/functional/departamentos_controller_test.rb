require 'test_helper'

class DepartamentosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:departamentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create departamento" do
    assert_difference('Departamento.count') do
      post :create, :departamento => { }
    end

    assert_redirected_to departamento_path(assigns(:departamento))
  end

  test "should show departamento" do
    get :show, :id => departamentos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => departamentos(:one).to_param
    assert_response :success
  end

  test "should update departamento" do
    put :update, :id => departamentos(:one).to_param, :departamento => { }
    assert_redirected_to departamento_path(assigns(:departamento))
  end

  test "should destroy departamento" do
    assert_difference('Departamento.count', -1) do
      delete :destroy, :id => departamentos(:one).to_param
    end

    assert_redirected_to departamentos_path
  end
end
