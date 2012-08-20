class Settings < Settingslogic
  source "#{Rails.root}/config/environment.yml"
  namespace Rails.env
end