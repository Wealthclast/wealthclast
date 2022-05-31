require "test_helper"

class PathOfExile::APITest < ActiveSupport::TestCase
  setup do
    @league_name = "Standard"
    @random_string ||= SecureRandom.base58
    @client ||= PathOfExile::API.new(access_token: @random_string)
  end

  test "#profile" do
    VCR.use_cassette("profile") do
      @client.profile
    end

    assert_requested(
      :get,
      "https://api.pathofexile.com/profile",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@random_string}"
      },
      times: 1
    )
  end

  test "#account_characters" do
    VCR.use_cassette("character") do
      @client.account_characters
    end

    assert_requested(
      :get,
      "https://api.pathofexile.com/character",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@random_string}"
      },
      times: 1
    )
  end

  test "#stashes" do
    VCR.use_cassette("stashes") do
      @client.stashes(league_name: @league_name)
    end

    assert_requested(
      :get,
      "https://api.pathofexile.com/stash/#{@league_name}",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@random_string}"
      },
      times: 1
    )
  end

  test "#stash" do
    VCR.use_cassette("stashes") do
      @client.stashes(league_name: @league_name)
    end

    assert_requested(
      :get,
      "https://api.pathofexile.com/stash/#{@league_name}",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@random_string}"
      },
      times: 1
    )
  end

  test "#stash without substash_id" do
    stash_id = "ca3285d0d2"

    VCR.use_cassette("folder_stash") do
      @client.stash(
        league_name: @league_name,
        stash_id: stash_id
      )
    end

    assert_requested(
      :get,
      "https://api.pathofexile.com/stash/#{@league_name}/#{stash_id}",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@random_string}"
      },
      times: 1
    )
  end

  test "#stash with substash_id" do
    stash_id = "ca3285d0d2"
    substash_id = "7872ff05cb"

    VCR.use_cassette("stash") do
      @client.stash(
        league_name: @league_name,
        stash_id: stash_id,
        substash_id: substash_id
      )
    end

    assert_requested(
      :get,
      "https://api.pathofexile.com/stash/#{@league_name}/#{stash_id}/#{substash_id}",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@random_string}"
      },
      times: 1
    )
  end

  test "#leagues" do
    VCR.use_cassette("leagues") do
      @client.leagues
    end

    assert_requested(
      :get,
      "https://api.pathofexile.com/leagues",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{Rails.application.credentials.oauth_client_token}"
      },
      times: 1
    )
  end

  test "#league" do
    VCR.use_cassette("league") do
      @client.league(name: @league_name)
    end

    assert_requested(
      :get,
      "https://api.pathofexile.com/league/#{@league_name}",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{Rails.application.credentials.oauth_client_token}"
      },
      times: 1
    )
  end
end
