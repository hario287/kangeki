require "test_helper"

class Admin::ReviewCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_review_comments_destroy_url
    assert_response :success
  end
end
