module PathOfExile
  module APIHelper
    def stub_get_profile(uuid: SecureRandom.uuid)
      profile_body = {uuid: uuid, name: "Fladson", guild: {name: "wealthclast"}}
      stub_http_request(:get, "https://api.pathofexile.com/profile")
        .and_return(status: 200, body: profile_body.to_json, headers: {content_type: "application/json"})
    end
  end
end
