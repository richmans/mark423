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
    check "Visible"
    fill_in "recorded at", with: @recording.recorded_at
    fill_in "speaker", with: "MySpeakerXYZ"
    fill_in "theme", with: "MyRecordingABC"
    attach_file('recording_audio_file', Rails.root + 'test/fixtures/files/gameover.mp3', make_visible: true)
    attach_file "recording_image_file", file_fixture("fun.jpeg")
    click_on "Create recording"
    assert_text "Recording was successfully created"
    click_on "MyRecording"
    assert_text "Audio file was not analyzed yet"
    assert_text "This recording is not published because"
    perform_enqueued_jobs # Analyze mp3s
    perform_enqueued_jobs # Generate (update) podcast
    visit current_url
    assert_no_text "Audio file was not analyzed yet"
    assert_no_text "This recording is not published because"
    visit render_player_url(podcasts(:one).shortname)
    assert_text "MyRecordingABC"
    assert_text "MySpeakerXYZ"
  end

  test "should update Recording" do
    login_admin
    visit recordings_url
    click_on "MyString", match: :first

    fill_in "description", with: @recording.description
    check "Visible"
    fill_in "recorded at", with: @recording.recorded_at
    fill_in "speaker", with: @recording.speaker
    fill_in "theme", with: "MyUpdatedRecording"
    attach_file('recording_audio_file', Rails.root + 'test/fixtures/files/swoosh.mp3', make_visible: true)
    attach_file "recording_image_file", file_fixture("fun.jpeg")
    click_on "Update recording"

    assert_text "Recording was successfully updated"
    click_on "MyUpdatedRecording"
    assert_text "Audio file was not analyzed yet"
    perform_enqueued_jobs
    visit current_url
    assert_no_text "Audio file was not analyzed yet"
  end

  test "should destroy Recording" do
    login_admin
    visit recordings_url
    accept_alert do
      click_on "Delete", match: :first
    end
    assert_text "Recording was successfully destroyed"
  end
end
