require "application_system_test_case"

class RecordingsTest < ApplicationSystemTestCase
  setup do
    @recording = recordings(:one)
  end

  test "visiting the index" do
    login_admin
    visit recordings_url
    assert_selector "h1", text: "Recordings"
  end

  test "should create recording" do
    login_admin
    visit recordings_url
    click_on "New recording"

    fill_in "Description", with: @recording.description
    check "Published" if @recording.published
    fill_in "Recorded at", with: @recording.recorded_at
    fill_in "Speaker", with: @recording.speaker
    fill_in "Theme", with: @recording.theme
    click_on "Create Recording"

    assert_text "Recording was successfully created"
    click_on "Back"
  end

  test "should update Recording" do
    login_admin
    visit recording_url(@recording)
    click_on "Edit this recording", match: :first

    fill_in "Description", with: @recording.description
    check "Published" if @recording.published
    fill_in "Recorded at", with: @recording.recorded_at
    fill_in "Speaker", with: @recording.speaker
    fill_in "Theme", with: @recording.theme
    click_on "Update Recording"

    assert_text "Recording was successfully updated"
    click_on "Back"
  end

  test "should destroy Recording" do
    login_admin
    visit recording_url(@recording)
    click_on "Destroy this recording", match: :first

    assert_text "Recording was successfully destroyed"
  end
end
