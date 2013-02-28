# Be sure to restart your server when you modify this file.

Frustration::Application.config.session_store :cookie_store,
  key: '_frustration_session',
  expire_after: 30.day

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Frustration::Application.config.session_store :active_record_store
