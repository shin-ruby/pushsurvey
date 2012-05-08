# -*- encoding : utf-8 -*-
require 'test_helper'

class DesignsControllerTest < ActionController::TestCase
  setup do
    @design = designs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:designs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create design" do
    assert_difference('Design.count') do
      post :create, :design => @design.attributes
    end

    assert_redirected_to design_path(assigns(:design))
  end

  test "should show design" do
    get :show, :id => @design.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @design.to_param
    assert_response :success
  end

  test "should update design" do
    put :update, :id => @design.to_param, :design => @design.attributes
    assert_redirected_to design_path(assigns(:design))
  end

  test "should destroy design" do
    assert_difference('Design.count', -1) do
      delete :destroy, :id => @design.to_param
    end

    assert_redirected_to designs_path
  end
end
