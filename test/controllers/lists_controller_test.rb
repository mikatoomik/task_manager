require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list = lists(:one)
  end

  test "should get index" do
    get lists_url
    assert_response :success
  end
end
