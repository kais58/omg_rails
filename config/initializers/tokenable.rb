# How long should the token be valid for?
# After this time, it will return Tokenable::Unauthorized
# You can set this to nil for tokens to never expire
Tokenable::Config.lifespan = 7.days

# The class in which your User resides.
Tokenable::Config.user_class = Player

# The secret used to create these tokens. This is then used to verify the
# token is valid. Note: Tokens are not encrypted, and container the user_id.
# You can change this to any 256-bit string
Tokenable::Config.secret = Rails.application.secret_key_base
