RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers

  # config.before :suite do
  #   Warden.test_mode!
  # end
end
