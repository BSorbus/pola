require 'test_helper'

class Projects::AccessorizationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get projects_accessorizations_new_url
    assert_response :success
  end

  test "should get create" do
    get projects_accessorizations_create_url
    assert_response :success
  end

  test "should get edit" do
    get projects_accessorizations_edit_url
    assert_response :success
  end

  test "should get update" do
    get projects_accessorizations_update_url
    assert_response :success
  end

end
