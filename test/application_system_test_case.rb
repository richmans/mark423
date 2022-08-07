require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  def login_as(email, password)
    visit login_url
    assert_selector("h2", text: "Log in")
    fill_in("email", with: email)
    fill_in("password", with: password)
    click_on "Log in"
    assert_text("Welcome")
  end

  def login_admin
    login_as("admin@mark423.test", "admin")
  end

  # Cleanup activestorage files
  def after_teardown
    super
    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end
end
