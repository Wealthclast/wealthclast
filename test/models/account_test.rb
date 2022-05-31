require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "leagues playing" do
    account = accounts(:one)
    expected_leagues = ["Standard", "Wealthclast", "Wealthclast SSF"].sort
    assert_equal account.leagues_playing.sort, expected_leagues
  end
end
