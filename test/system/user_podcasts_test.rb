require "application_system_test_case"

class UserPodcastsTest < ApplicationSystemTestCase
  setup do
    @user_podcast = user_podcasts(:one)
  end

  test "visiting the index" do
    visit user_podcasts_url
    assert_selector "h1", text: "User podcasts"
  end

  test "should create user podcast" do
    visit user_podcasts_url
    click_on "New user podcast"

    fill_in "Podcast", with: @user_podcast.podcast_id
    fill_in "Role", with: @user_podcast.role
    fill_in "User", with: @user_podcast.user_id
    click_on "Create User podcast"

    assert_text "User podcast was successfully created"
    click_on "Back"
  end

  test "should update User podcast" do
    visit user_podcast_url(@user_podcast)
    click_on "Edit this user podcast", match: :first

    fill_in "Podcast", with: @user_podcast.podcast_id
    fill_in "Role", with: @user_podcast.role
    fill_in "User", with: @user_podcast.user_id
    click_on "Update User podcast"

    assert_text "User podcast was successfully updated"
    click_on "Back"
  end

  test "should destroy User podcast" do
    visit user_podcast_url(@user_podcast)
    click_on "Destroy this user podcast", match: :first

    assert_text "User podcast was successfully destroyed"
  end
end
