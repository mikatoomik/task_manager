# frozen_string_literal: true

require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list = lists(:one)
  end

  test "should get index" do
    get lists_url
    assert_response :success
  end

  test "should get new" do
    get new_list_url
    assert_response :success
  end

  test "should create list" do
    assert_difference("List.count") do
      post lists_url, params: { list: { title: "New List", description: "desc" } }
    end
    assert_redirected_to lists_url
  end

  test "should show list" do
    get list_url(@list)
    assert_response :success
  end

  test "should get edit" do
    get edit_list_url(@list)
    assert_response :success
  end

  test "should update list" do
    patch list_url(@list), params: { list: { title: "Updated", description: "desc" } }
    assert_redirected_to list_url(@list)
    @list.reload
    assert_equal "Updated", @list.title
  end

  test "should destroy list if all tasks are complete" do
    @list.tasks.update_all(completed: true)
    assert_difference("List.count", -1) do
      delete list_url(@list)
    end
    assert_redirected_to lists_url
  end

  test "should not destroy list if it has incomplete tasks" do
    @list.tasks.create!(title: "Task", completed: false)
    assert_no_difference("List.count") do
      delete list_url(@list)
    end
    assert_redirected_to list_url(@list)
  end
end
