module PathOfExile
  module OAuthHelper
    def stub_token_request
      body = {
        access_token: SecureRandom.base58,
        expires_in: 2419200,
        token_type: "bearer",
        scope: "account:profile account:characters account:stashes",
        refresh_token: SecureRandom.base58
      }
      stub_http_request(:post, "https://www.pathofexile.com/oauth/token")
        .and_return(status: 200, body: body.to_json, headers: {content_type: "application/json"})
    end

    def stub_revoke_token
      stub_http_request(:post, "https://www.pathofexile.com/oauth/token/revoke").and_return(status: 200)
    end
  end
end
