ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

require "webmock/minitest"
require "httpx/adapters/webmock"

require "test_helpers/path_of_exile/oauth_helper"
class ActiveSupport::TestCase
  include PathOfExile::OAuthHelper
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  teardown do
    WebMock.reset!
    WebMock.allow_net_connect!
    WebMock.disable!
  end
end
