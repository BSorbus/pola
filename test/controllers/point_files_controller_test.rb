require 'test_helper'

class PointFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @point_file = point_files(:one)
  end

  test "should get index" do
    get point_files_url
    assert_response :success
  end

  test "should get new" do
    get new_point_file_url
    assert_response :success
  end

  test "should create point_file" do
    assert_difference('PointFile.count') do
      post point_files_url, params: { point_file: { load_date: @point_file.load_date, load_file: @point_file.load_file, note: @point_file.note, project_id: @point_file.project_id, status: @point_file.status } }
    end

    assert_redirected_to point_file_url(PointFile.last)
  end

  test "should show point_file" do
    get point_file_url(@point_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_point_file_url(@point_file)
    assert_response :success
  end

  test "should update point_file" do
    patch point_file_url(@point_file), params: { point_file: { load_date: @point_file.load_date, load_file: @point_file.load_file, note: @point_file.note, project_id: @point_file.project_id, status: @point_file.status } }
    assert_redirected_to point_file_url(@point_file)
  end

  test "should destroy point_file" do
    assert_difference('PointFile.count', -1) do
      delete point_file_url(@point_file)
    end

    assert_redirected_to point_files_url
  end
end
