module PathOfExile
  class API
    HOST = "api.pathofexile.com"

    def initialize(access_token:)
      @access_token = access_token
    end

    def profile
      HTTPX.get(
        URI::HTTPS.build(host: HOST, path: "/profile"),
        headers: {
          "User-Agent" => USER_AGENT,
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{@access_token}"
        }
      ).json
    end
  end
end
