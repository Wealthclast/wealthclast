module PathOfExile
  class OAuth
    HOST = "www.pathofexile.com"
    SCOPES = "account:profile account:stashes account:characters"
    REFRESH_TOKEN_TIMESPAN = 90.days

    class << self
      def authorization_code_grant_url(state:)
        URI::HTTPS.build(
          host: HOST,
          path: "/oauth/authorize",
          query: {
            client_id: Rails.application.credentials.oauth_id,
            response_type: "code",
            scope: SCOPES,
            state: state,
            redirect_uri: "https://wealthclast.com/auth/pathofexile/callback",
            prompt: "consent"
          }.to_query
        ).to_s
      end

      def get_access_token(code:)
        HTTPX.post(
          URI::HTTPS.build(host: HOST, path: "/oauth/token"),
          headers: headers,
          form: {
            client_id: Rails.application.credentials.oauth_id,
            client_secret: Rails.application.credentials.oauth_secret,
            grant_type: "authorization_code",
            code: code,
            redirect_uri: "",
            scope: SCOPES
          }
        ).json
      end

      def revoke_token(token:)
        HTTPX.post(
          URI::HTTPS.build(host: HOST, path: "/oauth/token/revoke"),
          headers: headers,
          form: {
            token: token,
            scope: "oauth:revoke"
          }
        )
      end

      private

      def headers
        {
          "User-Agent" => USER_AGENT,
          "Content-Type" => "application/x-www-form-urlencoded"
        }
      end
    end
  end
end
