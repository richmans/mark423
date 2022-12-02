require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def setup
    Rails.application.routes.default_url_options[:host] = Capybara.current_session.server.host
    Rails.application.routes.default_url_options[:port] = Capybara.current_session.server.port
    Rails.application.config.app_url = "http://#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
    Rails.application.config.podcast_host = Rails.application.config.app_url + "/podcasts"
    #ActiveStorage::Current.url_options = {protocol: 'http', host: Capybara.current_session.server.host, port: Capybara.current_session.server.port }
  end

  def login_as(email, password)
    visit login_url
    assert_selector("h2", text: "Log in")
    fill_in("email", with: email)
    fill_in("password", with: password)
    click_on "Log in"
    assert_text("Recordings")
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
