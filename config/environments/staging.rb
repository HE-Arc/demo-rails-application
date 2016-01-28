# Based on development defaults

require Rails.root.join("config/environments/development")

Rails.application.configure do
  # Enable anyone to see the error messages.
  #config.web_console.whitelisted_ips = "157.26.66.0/24"
end
