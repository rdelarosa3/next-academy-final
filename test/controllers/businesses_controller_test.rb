require 'test_helper'

class BusinessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business = businesses(:one)
  end

  test "should get index" do
    get businesses_url
    assert_response :success
  end

  test "should get new" do
    get new_business_url
    assert_response :success
  end

  test "should create business" do
    assert_difference('Business.count') do
      post businesses_url, params: { business: { city: @business.city, country: @business.country, email: @business.email, facebook: @business.facebook, instagram: @business.instagram, link_id: @business.link_id, logo: @business.logo, name: @business.name, operator: @business.operator, phone: @business.phone, state: @business.state, street: @business.street, twitter: @business.twitter, youtube: @business.youtube, zipcode: @business.zipcode } }
    end

    assert_redirected_to business_url(Business.last)
  end

  test "should show business" do
    get business_url(@business)
    assert_response :success
  end

  test "should get edit" do
    get edit_business_url(@business)
    assert_response :success
  end

  test "should update business" do
    patch business_url(@business), params: { business: { city: @business.city, country: @business.country, email: @business.email, facebook: @business.facebook, instagram: @business.instagram, link_id: @business.link_id, logo: @business.logo, name: @business.name, operator: @business.operator, phone: @business.phone, state: @business.state, street: @business.street, twitter: @business.twitter, youtube: @business.youtube, zipcode: @business.zipcode } }
    assert_redirected_to business_url(@business)
  end

  test "should destroy business" do
    assert_difference('Business.count', -1) do
      delete business_url(@business)
    end

    assert_redirected_to businesses_url
  end
end
