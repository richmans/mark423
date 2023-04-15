require "test_helper"

class RecordingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as('admin@mark423.test', 'admin')
    @recording = recordings(:one)
  end

  test "should get index" do
    get recordings_url
    assert_response :success
  end

  test "should get new" do
    get new_recording_url
    assert_response :success
  end

  test "should create recording" do
    assert_difference("Recording.count") do
      post recordings_url, params: { recording: { description: @recording.description, podcast_id: @recording.podcast_id, published: @recording.published, recorded_at: @recording.recorded_at, speaker: @recording.speaker, theme: @recording.theme } }
    end

    assert_redirected_to recordings_url(format: :html)
  end

  test "should show recording" do
    get recording_url(@recording)
    assert_response :success
  end

  test "should get edit" do
    get edit_recording_url(@recording)
    assert_response :success
  end

  test "should update recording" do
    patch recording_url(@recording), params: { recording: { description: @recording.description, podcast_id: @recording.podcast_id, published: @recording.published, recorded_at: @recording.recorded_at, speaker: @recording.speaker, theme: @recording.theme } }
    assert_redirected_to recordings_url(format: :html)
  end

  test "should destroy recording" do
    assert_difference("Recording.count", -1) do
      delete recording_url(@recording)
    end

    assert_redirected_to recordings_url(format: :html)
  end
end
