require "application_system_test_case"

class BusinessesTest < ApplicationSystemTestCase
  setup do
    @business = businesses(:one)
  end

  test "visiting the index" do
    visit businesses_url
    assert_selector "h1", text: "Businesses"
  end

  test "creating a Business" do
    visit businesses_url
    click_on "New Business"

    fill_in "City", with: @business.city
    fill_in "Country", with: @business.country
    fill_in "Email", with: @business.email
    fill_in "Facebook", with: @business.facebook
    fill_in "Instagram", with: @business.instagram
    fill_in "Link", with: @business.link_id
    fill_in "Logo", with: @business.logo
    fill_in "Name", with: @business.name
    fill_in "Operator", with: @business.operator
    fill_in "Phone", with: @business.phone
    fill_in "State", with: @business.state
    fill_in "Street", with: @business.street
    fill_in "Twitter", with: @business.twitter
    fill_in "Youtube", with: @business.youtube
    fill_in "Zipcode", with: @business.zipcode
    click_on "Create Business"

    assert_text "Business was successfully created"
    click_on "Back"
  end

  test "updating a Business" do
    visit businesses_url
    click_on "Edit", match: :first

    fill_in "City", with: @business.city
    fill_in "Country", with: @business.country
    fill_in "Email", with: @business.email
    fill_in "Facebook", with: @business.facebook
    fill_in "Instagram", with: @business.instagram
    fill_in "Link", with: @business.link_id
    fill_in "Logo", with: @business.logo
    fill_in "Name", with: @business.name
    fill_in "Operator", with: @business.operator
    fill_in "Phone", with: @business.phone
    fill_in "State", with: @business.state
    fill_in "Street", with: @business.street
    fill_in "Twitter", with: @business.twitter
    fill_in "Youtube", with: @business.youtube
    fill_in "Zipcode", with: @business.zipcode
    click_on "Update Business"

    assert_text "Business was successfully updated"
    click_on "Back"
  end

  test "destroying a Business" do
    visit businesses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Business was successfully destroyed"
  end
end
