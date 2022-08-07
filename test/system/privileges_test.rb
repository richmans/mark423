require "application_system_test_case"

class PrivilegesTest < ApplicationSystemTestCase
  setup do
    @privilege = privileges(:one)
    @podcast = podcasts(:one)
  end

  test "visiting the index" do
    login_admin
    visit podcast_privileges_url(@podcast)
    assert_selector "h1", text: "Privileges"
  end

  test "should create privilege" do
    login_admin
    visit podcast_privileges_url(@podcast)
    click_on "New Privilege"
    find("select[name='privilege[user_id]']").find(:option, text: :Dirk).select_option 
    find("select[name='privilege[podcast_id]']").find(:option, text: :MyString).select_option 
    find("select[name='privilege[role]']").find(:option, text: :Viewer).select_option 
    click_on "Create privilege"

    assert_text "Privilege was successfully created"
    click_on "Back"
  end

  test "should update Privilege" do
    login_admin
    visit podcast_privilege_url(@podcast, @privilege)
    click_on "Edit this Privilege", match: :first
    find("select[name='privilege[user_id]']").find(:option, text: :Dirk).select_option 
    find("select[name='privilege[podcast_id]']").find(:option, text: :MyString).select_option 
    find("select[name='privilege[role]']").find(:option, text: :Viewer).select_option 
    
    click_on "Update privilege"

    assert_text "Privilege was successfully updated"
    click_on "Back"
  end

  test "should destroy Privilege" do
    login_admin
    visit podcast_privilege_url(@podcast, @privilege)
    click_on "Destroy this Privilege", match: :first

    assert_text "Privilege was successfully destroyed"
  end
end
