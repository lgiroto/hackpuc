require 'test_helper'

class DoctorsControllerTest < ActionController::TestCase
  test "should get results" do
    get :results
    assert_response :success
  end

end
