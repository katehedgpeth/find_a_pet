require "net/http"


class PetfinderService

  BASE_URL = "https://api.petfinder.com/v2"

  ENDPOINTS = {
    "token" => "oauth2/token",
    "animals" => "animals",
    "animal_types" => "types"
  }

  def bearer_token_cache_key
    "petfinder/bearer_token"
  end

  def url(endpoint, resource = nil)
    [BASE_URL, ENDPOINTS[endpoint], resource]
      .reject { |part| part.nil? }
      .join("/")
  end

  def params(endpoint)
    @endpoint_params = {
      "token" => {
        :grant_type => "client_credentials",
        :client_id => ENV["PETFINDER_API_KEY"],
        :client_secret => ENV["PETFINDER_SECRET"]
      }
    }

    @endpoint_params[endpoint]
  end

  def get_bearer_token()
    # TODO: cache
    # TODO: handle bad response
    url("token")
      .then { URI.parse(_1) }
      .then { Net::HTTP.post_form(_1, params("token"))}
      .then { JSON.parse(_1.body)["access_token"] }
  end

  def call_api(endpoint, resource = nil, params = {})
    # TODO: cache
    # TODO: handle bad response
    url(endpoint, resource)
      .then { URI.parse(_1) }
      .then { add_params(_1, params) }
      .then { Net::HTTP.get(_1, headers=headers())}
      .then { JSON.parse(_1) }
  end

  private

  def headers
    { "Authorization" => "Bearer #{get_bearer_token()}" }
  end

  def add_params(uri, params)
    uri.query = URI.encode_www_form(params) unless params.empty?
    return uri
  end
end