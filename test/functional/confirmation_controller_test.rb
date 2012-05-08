# -*- encoding : utf-8 -*-
require 'test_helper'

class ConfirmationControllerTest < ActionController::TestCase
  test "should get confirmation" do
    get :confirmation
    assert_response :success
  end

end
