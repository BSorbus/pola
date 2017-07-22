require 'test_helper'

class WwPointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ww_point = ww_points(:one)
  end

  test "should get index" do
    get ww_points_url
    assert_response :success
  end

  test "should get new" do
    get new_ww_point_url
    assert_response :success
  end

  test "should create ww_point" do
    assert_difference('WwPoint.count') do
      post ww_points_url, params: { ww_point: { point_file_id: @ww_point.point_file_id, ww_2: @ww_point.ww_2 } }
    end

    assert_redirected_to ww_point_url(WwPoint.last)
  end

  test "should show ww_point" do
    get ww_point_url(@ww_point)
    assert_response :success
  end

  test "should get edit" do
    get edit_ww_point_url(@ww_point)
    assert_response :success
  end

  test "should update ww_point" do
    patch ww_point_url(@ww_point), params: { ww_point: { point_file_id: @ww_point.point_file_id, ww_2: @ww_point.ww_2 } }
    assert_redirected_to ww_point_url(@ww_point)
  end

  test "should destroy ww_point" do
    assert_difference('WwPoint.count', -1) do
      delete ww_point_url(@ww_point)
    end

    assert_redirected_to ww_points_url
  end
end
