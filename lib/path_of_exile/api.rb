module PathOfExile
  class API
    HOST = "api.pathofexile.com"

    # TODO: check token validity before making requests
    def initialize(access_token: nil)
      @access_token = access_token
    end

    # This request is only made at login, no need to check token validity
    def profile
      make_request(path: "/profile")
    end

    def account_characters
      make_request(path: "/character")
    end

    def stashes(league_name:)
      make_request(path: "/stash/#{CGI.escape(league_name)}")
    end

    def stash(league_name:, stash_id:, substash_id: nil)
      path = "/stash/#{CGI.escape(league_name)}/#{stash_id}"
      path << "/#{substash_id}" if substash_id
      make_request(path: path)
    end

    def leagues
      make_request(
        path: "/leagues",
        token: Rails.application.credentials.oauth_client_token
      )
    end

    def league(name:)
      make_request(
        path: "/league/#{CGI.escape(name)}",
        token: Rails.application.credentials.oauth_client_token
      )
    end

    private

    def make_request(path:, token: @access_token)
      HTTPX.get(
        URI::HTTPS.build(host: HOST, path: path),
        headers: {
          "User-Agent" => USER_AGENT,
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{token}"
        }
      ).json
    end
  end
end
