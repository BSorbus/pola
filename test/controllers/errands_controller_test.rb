require 'test_helper'

class ErrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @errand = errands(:one)
  end

  test "should get index" do
    get errands_url
    assert_response :success
  end

  test "should get new" do
    get new_errand_url
    assert_response :success
  end

  test "should create errand" do
    assert_difference('Errand.count') do
      post errands_url, params: { errand: { adoption_date: @errand.adoption_date, end_date: @errand.end_date, errand_status_id: @errand.errand_status_id, errand_type_id: @errand.errand_type_id, note: @errand.note, number: @errand.number, order_date: @errand.order_date, principal: @errand.principal, start_date: @errand.start_date } }
    end

    assert_redirected_to errand_url(Errand.last)
  end

  test "should show errand" do
    get errand_url(@errand)
    assert_response :success
  end

  test "should get edit" do
    get edit_errand_url(@errand)
    assert_response :success
  end

  test "should update errand" do
    patch errand_url(@errand), params: { errand: { adoption_date: @errand.adoption_date, end_date: @errand.end_date, errand_status_id: @errand.errand_status_id, errand_type_id: @errand.errand_type_id, note: @errand.note, number: @errand.number, order_date: @errand.order_date, principal: @errand.principal, start_date: @errand.start_date } }
    assert_redirected_to errand_url(@errand)
  end

  test "should destroy errand" do
    assert_difference('Errand.count', -1) do
      delete errand_url(@errand)
    end

    assert_redirected_to errands_url
  end
end
