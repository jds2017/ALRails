# Load the Rails application.
require_relative 'application'

require 'casclient'

require 'casclient/frameworks/rails/filter'

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url  => "https://login.gatech.edu/cas/"
)

# Initialize the Rails application.
Rails.application.initialize!
