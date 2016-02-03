# Based on development defaults

require Rails.root.join("config/environments/development")

Rails.application.configure do
  # Enable anyone to see the error messages.
  #config.web_console.whitelisted_ips = "157.26.66.0/24"

  # Sending emails
  config.action_mailer.smtp_settings = {
    address: 'mailcatcher',
    port: 1025
  }
  config.action_mailer.default_url_options = {host: 'admin.srvz-webapp.he-arc.ch'}

end
