require 'test_helper'

class ZsPointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @zs_point = zs_points(:one)
  end

  test "should get index" do
    get zs_points_url
    assert_response :success
  end

  test "should get new" do
    get new_zs_point_url
    assert_response :success
  end

  test "should create zs_point" do
    assert_difference('ZsPoint.count') do
      post zs_points_url, params: { zs_point: { point_file_id: @zs_point.point_file_id, zs_2: @zs_point.zs_2 } }
    end

    assert_redirected_to zs_point_url(ZsPoint.last)
  end

  test "should show zs_point" do
    get zs_point_url(@zs_point)
    assert_response :success
  end

  test "should get edit" do
    get edit_zs_point_url(@zs_point)
    assert_response :success
  end

  test "should update zs_point" do
    patch zs_point_url(@zs_point), params: { zs_point: { point_file_id: @zs_point.point_file_id, zs_2: @zs_point.zs_2 } }
    assert_redirected_to zs_point_url(@zs_point)
  end

  test "should destroy zs_point" do
    assert_difference('ZsPoint.count', -1) do
      delete zs_point_url(@zs_point)
    end

    assert_redirected_to zs_points_url
  end
end
