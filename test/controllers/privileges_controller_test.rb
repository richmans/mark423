require "test_helper"

class PrivilegesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as('admin@mark423.test', 'admin')
    @privilege = privileges(:one)
    @podcast = podcasts(:one)
  end

  test "should get index" do
    get podcast_privileges_url(@podcast)
    assert_response :success
  end

  test "should get new" do
    get new_podcast_privilege_url(@podcast)
    assert_response :success
  end

  test "should create privilege" do
    assert_difference("Privilege.count") do
      post podcast_privileges_url(@podcast), params: { privilege: { podcast_id: @privilege.podcast_id, role: @privilege.role, user_id: @privilege.user_id } }
    end

    assert_redirected_to podcast_privileges_url(Podcast.first)
  end

  test "should show privilege" do
    get podcast_privilege_url(@podcast, @privilege)
    assert_response :success
  end

  test "should get edit" do
    get edit_podcast_privilege_url(@podcast, @privilege)
    assert_response :success
  end

  test "should update privilege" do
    patch podcast_privilege_url(@podcast, @privilege), params: { privilege: { podcast_id: @privilege.podcast_id, role: @privilege.role, user_id: @privilege.user_id } }
    assert_redirected_to podcast_privileges_url(@podcast)
  end

  test "should destroy privilege" do
    assert_difference("Privilege.count", -1) do
      delete podcast_privilege_url(@podcast, @privilege)
    end

    assert_redirected_to podcast_privileges_url(@podcast)
  end
end
