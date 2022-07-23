require "application_system_test_case"

class SessionTest < ApplicationSystemTestCase
  setup do
    @user = users(:admin)
  end

  test "visiting the index" do
    visit root_url
    assert_selector "h2", text: "Log in"
  end

  test "logging in and out" do
    visit login_url
    assert_selector("h2", text: "Log in")
    fill_in("email", with: "dirk@mark423.test")
    fill_in("password", with: "dirk")
    click_on "Log in"
    assert_text("Welcome")
    click_on "Logout"
    assert_selector "h2", text: "Log in"
  end
end