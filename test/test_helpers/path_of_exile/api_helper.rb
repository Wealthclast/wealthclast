module PathOfExile
  module APIHelper
    def stub_get_profile
      profile_body = {uuid: SecureRandom.uuid, name: "Fladson"}
      stub_http_request(:get, "https://api.pathofexile.com/profile")
        .and_return(status: 200, body: profile_body.to_json, headers: {content_type: "application/json"})
    end
  end
end
