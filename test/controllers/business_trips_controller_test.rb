require 'test_helper'

class BusinessTripsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business_trip = business_trips(:one)
  end

  test "should get index" do
    get business_trips_url
    assert_response :success
  end

  test "should get new" do
    get new_business_trip_url
    assert_response :success
  end

  test "should create business_trip" do
    assert_difference('BusinessTrip.count') do
      post business_trips_url, params: { business_trip: { destination: @business_trip.destination, end: @business_trip.end, note: @business_trip.note, number: @business_trip.number, purpose: @business_trip.purpose, start: @business_trip.start, user_id: @business_trip.user_id } }
    end

    assert_redirected_to business_trip_url(BusinessTrip.last)
  end

  test "should show business_trip" do
    get business_trip_url(@business_trip)
    assert_response :success
  end

  test "should get edit" do
    get edit_business_trip_url(@business_trip)
    assert_response :success
  end

  test "should update business_trip" do
    patch business_trip_url(@business_trip), params: { business_trip: { destination: @business_trip.destination, end: @business_trip.end, note: @business_trip.note, number: @business_trip.number, purpose: @business_trip.purpose, start: @business_trip.start, user_id: @business_trip.user_id } }
    assert_redirected_to business_trip_url(@business_trip)
  end

  test "should destroy business_trip" do
    assert_difference('BusinessTrip.count', -1) do
      delete business_trip_url(@business_trip)
    end

    assert_redirected_to business_trips_url
  end
end
