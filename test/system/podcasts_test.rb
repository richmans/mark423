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
    click_on "New Podcast"

    fill_in "author", with: @podcast.author
    fill_in "copyright", with: @podcast.copyright
    fill_in "email", with: @podcast.email
    fill_in "keywords", with: @podcast.keywords
    fill_in "name", with: @podcast.name
    fill_in "shortname", with: @podcast.shortname+ "-copy"
    attach_file "podcast_image_file", file_fixture("podcast2.jpg")
    click_on "Create podcast"

    assert_text "Podcast was successfully created"
  end

  test "should update Podcast" do
    login_admin
    visit podcast_url(@podcast)
    click_on "Edit this Podcast", match: :first

    fill_in "author", with: @podcast.author
    fill_in "copyright", with: @podcast.copyright
    fill_in "email", with: @podcast.email
    fill_in "keywords", with: @podcast.keywords
    fill_in "name", with: @podcast.name
    fill_in "shortname", with: @podcast.shortname
    attach_file "podcast_image_file", file_fixture("podcast.jpg")
    click_on "Update podcast"

    assert_text "Podcast was successfully updated"
  end

  test "should destroy Podcast" do
    login_admin
    visit podcast_url(@podcast)
    click_on "Destroy this Podcast", match: :first

    assert_text "Podcast was successfully destroyed"
  end
end
