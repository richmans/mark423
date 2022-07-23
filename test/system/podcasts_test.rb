require "application_system_test_case"

class PodcastsTest < ApplicationSystemTestCase
  setup do
    @podcast = podcasts(:one)
  end

  test "visiting the index" do
    login_admin
    visit podcasts_url
    assert_selector "h1", text: "Podcasts"
  end

  test "should create podcast" do
    login_admin
    visit podcasts_url
    click_on "New podcast"

    fill_in "Author", with: @podcast.author
    fill_in "Copyright", with: @podcast.copyright
    fill_in "Email", with: @podcast.email
    fill_in "Keywords", with: @podcast.keywords
    fill_in "Name", with: @podcast.name
    fill_in "Shortname", with: @podcast.shortname+ "-copy"
    click_on "Create Podcast"

    assert_text "Podcast was successfully created"
    click_on "Back"
  end

  test "should update Podcast" do
    login_admin
    visit podcast_url(@podcast)
    click_on "Edit this podcast", match: :first

    fill_in "Author", with: @podcast.author
    fill_in "Copyright", with: @podcast.copyright
    fill_in "Email", with: @podcast.email
    fill_in "Keywords", with: @podcast.keywords
    fill_in "Name", with: @podcast.name
    fill_in "Shortname", with: @podcast.shortname
    click_on "Update Podcast"

    assert_text "Podcast was successfully updated"
    click_on "Back"
  end

  test "should destroy Podcast" do
    login_admin
    visit podcast_url(@podcast)
    click_on "Destroy this podcast", match: :first

    assert_text "Podcast was successfully destroyed"
  end
end
