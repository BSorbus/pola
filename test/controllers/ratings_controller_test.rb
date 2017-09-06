require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rating = ratings(:one)
  end

  test "should get index" do
    get ratings_url
    assert_response :success
  end

  test "should get new" do
    get new_rating_url
    assert_response :success
  end

  test "should create rating" do
    assert_difference('Rating.count') do
      post ratings_url, params: { rating: { event_id: @rating.event_id, sec22: @rating.sec22, sec22_rate: @rating.sec22_rate, sec23: @rating.sec23, sec23_rate: @rating.sec23_rate, sec24: @rating.sec24, sec24_rate: @rating.sec24_rate, sec25: @rating.sec25, sec25_rate: @rating.sec25_rate, sec28: @rating.sec28, sec28_rate: @rating.sec28_rate, sec33: @rating.sec33, sec33_rate: @rating.sec33_rate, sec41: @rating.sec41, sec42: @rating.sec42, sec43: @rating.sec43, sec51: @rating.sec51, sec51_rate: @rating.sec51_rate, sec61: @rating.sec61, user_id: @rating.user_id } }
    end

    assert_redirected_to rating_url(Rating.last)
  end

  test "should show rating" do
    get rating_url(@rating)
    assert_response :success
  end

  test "should get edit" do
    get edit_rating_url(@rating)
    assert_response :success
  end

  test "should update rating" do
    patch rating_url(@rating), params: { rating: { event_id: @rating.event_id, sec22: @rating.sec22, sec22_rate: @rating.sec22_rate, sec23: @rating.sec23, sec23_rate: @rating.sec23_rate, sec24: @rating.sec24, sec24_rate: @rating.sec24_rate, sec25: @rating.sec25, sec25_rate: @rating.sec25_rate, sec28: @rating.sec28, sec28_rate: @rating.sec28_rate, sec33: @rating.sec33, sec33_rate: @rating.sec33_rate, sec41: @rating.sec41, sec42: @rating.sec42, sec43: @rating.sec43, sec51: @rating.sec51, sec51_rate: @rating.sec51_rate, sec61: @rating.sec61, user_id: @rating.user_id } }
    assert_redirected_to rating_url(@rating)
  end

  test "should destroy rating" do
    assert_difference('Rating.count', -1) do
      delete rating_url(@rating)
    end

    assert_redirected_to ratings_url
  end
end
