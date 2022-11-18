Rails.application.config_for(:mailer).keys.each do |option_name|
  Rails.configuration.action_mailer[option_name] = Rails.application.config_for(:mailer)[option_name]
end
