require 'test_helper'

class OpinionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @opinion = opinions(:one)
  end

  test "should get index" do
    get opinions_url
    assert_response :success
  end

  test "should get new" do
    get new_opinion_url
    assert_response :success
  end

  test "should create opinion" do
    assert_difference('Opinion.count') do
      post opinions_url, params: { opinion: { project_id: @opinion.project_id, sec22: @opinion.sec22, sec22_rate: @opinion.sec22_rate, sec23: @opinion.sec23, sec23_rate: @opinion.sec23_rate, sec24: @opinion.sec24, sec24_rate: @opinion.sec24_rate, sec25: @opinion.sec25, sec25_rate: @opinion.sec25_rate, sec28: @opinion.sec28, sec28_rate: @opinion.sec28_rate, sec33: @opinion.sec33, sec33_rate: @opinion.sec33_rate, sec41: @opinion.sec41, sec42: @opinion.sec42, sec43: @opinion.sec43, sec51: @opinion.sec51, sec51_rate: @opinion.sec51_rate, sec61: @opinion.sec61, user_id: @opinion.user_id } }
    end

    assert_redirected_to opinion_url(Opinion.last)
  end

  test "should show opinion" do
    get opinion_url(@opinion)
    assert_response :success
  end

  test "should get edit" do
    get edit_opinion_url(@opinion)
    assert_response :success
  end

  test "should update opinion" do
    patch opinion_url(@opinion), params: { opinion: { project_id: @opinion.project_id, sec22: @opinion.sec22, sec22_rate: @opinion.sec22_rate, sec23: @opinion.sec23, sec23_rate: @opinion.sec23_rate, sec24: @opinion.sec24, sec24_rate: @opinion.sec24_rate, sec25: @opinion.sec25, sec25_rate: @opinion.sec25_rate, sec28: @opinion.sec28, sec28_rate: @opinion.sec28_rate, sec33: @opinion.sec33, sec33_rate: @opinion.sec33_rate, sec41: @opinion.sec41, sec42: @opinion.sec42, sec43: @opinion.sec43, sec51: @opinion.sec51, sec51_rate: @opinion.sec51_rate, sec61: @opinion.sec61, user_id: @opinion.user_id } }
    assert_redirected_to opinion_url(@opinion)
  end

  test "should destroy opinion" do
    assert_difference('Opinion.count', -1) do
      delete opinion_url(@opinion)
    end

    assert_redirected_to opinions_url
  end
end
