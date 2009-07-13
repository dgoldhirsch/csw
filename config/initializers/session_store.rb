# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_csw_session',
  :secret      => '7b53a1736a7c85c268d5a38bf745a78d0a8672fd91fc964fb930ab83277b53cf0a6856162db633a8f2a74602394de4efec39580bf6a59acdb249d809d84813c5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
