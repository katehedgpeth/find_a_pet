require "net/http"


class PetfinderService

  BASE_URL = "https://api.petfinder.com/v2"
  CLIENT_ID = ENV["PETFINDER_API_KEY"]
  CLIENT_SECRET = ENV["PETFINDER_SECRET"]

  ENDPOINTS = {
    "token" => "oauth2/token",
    "animals" => "animals",
    "animal_types" => "types"
  }

  def bearer_token_cache_key
    "petfinder/bearer_token"
  end

  def url(endpoint)
    return "#{BASE_URL}/#{ENDPOINTS[endpoint]}"
  end

  def get_bearer_token(force: false, base_url: BASE_URL)
    # TODO: cache
    # TODO: handle bad response
    return url("token")
      .then { URI.parse(_1) }
      .then { Net::HTTP.post_form(_1, {
        :grant_type => "client_credentials",
        :client_id => CLIENT_ID,
        :client_secret => CLIENT_SECRET
      })}
      .then { JSON.parse(_1.body)["access_token"] }
  end

  def call_api(endpoint, base_url: BASE_URL)
    # TODO: cache
    # TODO: handle bad response
    token = get_bearer_token(base_url: base_url)

    return url(endpoint) 
      .then { URI.parse(_1) }
      .then { Net::HTTP.get(_1, headers={
        "Authorization" => "Bearer #{token}"
      }) }
      .then { JSON.parse(_1) }
  end
end