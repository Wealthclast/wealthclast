raise "OAuth client ID missing" unless Rails.application.credentials.oauth_id
raise "OAuth secret missing" unless Rails.application.credentials.oauth_secret
