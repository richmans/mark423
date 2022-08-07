require "application_system_test_case"

class RecordingsTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper
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
    click_on "New Recording"

    fill_in "description", with: @recording.description
    check "published" if @recording.published
    fill_in "recorded at", with: @recording.recorded_at
    fill_in "speaker", with: @recording.speaker
    fill_in "theme", with: @recording.theme
    attach_file('recording_audio_file', Rails.root + 'test/fixtures/files/gameover.mp3', make_visible: true)
    click_on "Create recording"

    assert_text "Recording was successfully created"
    assert_text "Duration:Unknown"
    perform_enqueued_jobs
    visit current_url
    assert_text "Duration:2 seconds"
    click_on "Back"
  end

  test "should update Recording" do
    login_admin
    visit recording_url(@recording)
    click_on "Edit this Recording", match: :first

    fill_in "description", with: @recording.description
    check "published" if @recording.published
    fill_in "recorded at", with: @recording.recorded_at
    fill_in "speaker", with: @recording.speaker
    fill_in "theme", with: @recording.theme
    attach_file('recording_audio_file', Rails.root + 'test/fixtures/files/swoosh.mp3', make_visible: true)
    click_on "Update recording"

    assert_text "Recording was successfully updated"
    assert_text "Duration:Unknown"
    perform_enqueued_jobs
    visit current_url
    assert_text "Duration:5 seconds"
    click_on "Back"
  end

  test "should destroy Recording" do
    login_admin
    visit recording_url(@recording)
    click_on "Destroy this Recording", match: :first

    assert_text "Recording was successfully destroyed"
  end
end
