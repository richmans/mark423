require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    login_admin
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "should create user" do
    login_admin
    visit users_url
    click_on "New User"

    fill_in "email", with: "newuser@mark423.test"
    fill_in "full name", with: "New user"
    fill_in "password", with: "dirk"
    fill_in "password confirmation", with: "dirk"
    click_on "Create user"

    assert_text "User was successfully created"
  end

  test "should update User" do
    login_admin
    visit user_url(@user)
    click_on "Edit this User", match: :first

    fill_in "email", with: @user.email
    fill_in "full name", with: @user.full_name
    fill_in "password", with: "dirk"
    fill_in "password confirmation", with: "dirk"
    click_on "Update user"

    assert_text "User was successfully updated"
  end

  test "should destroy User" do
    login_admin
    visit users_url
    accept_alert do
      all("[title=Delete]").last.click
    end
    assert_text "User was successfully destroyed"
  end
end
