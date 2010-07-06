# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Curso_session',
  :secret      => '7892832cf013a09fc2e89f21b12966b97b58cdbce21b73bc87082a97a68d73fdf295d79d37ce1e89dcf804ad216e577e9666516ca185c4480c0b37209d8441e8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
