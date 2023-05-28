require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get follows" do
    get relationships_follows_url
    assert_response :success
  end

  test "should get follower" do
    get relationships_follower_url
    assert_response :success
  end
end
