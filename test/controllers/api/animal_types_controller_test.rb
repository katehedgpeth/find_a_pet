require "test_helper"

TOKEN = "thisisareallyreallyreallylongbearertoken"

TOKEN_BODY = JSON.generate({
      "token_type" => "Bearer",
      "expires_in" => 3600,
      "access_token" => TOKEN
    })

EXPECTED_TYPES = [
  "Dog",
  "Cat",
  "Rabbit",
  "Small u0026 Furry",
  "Horse",
  "Bird",
  "Scales, Fins u0026 Other",
  "Barnyard"
]

class Api::AnimalTypesControllerTest < ActionDispatch::IntegrationTest
  test "index should return a list of animal type names" do
    service = PetfinderService.new()
    stub_request(:post, service.url("token"))
      .to_return(body: TOKEN_BODY)

    stub_request(:get, service.url("animal_types"))
      .to_return(body: File.new("test/fixtures/files/petfinder/types.json"))

    get "/api/v1/animal_types", xhr: true

    assert_equal JSON.generate(EXPECTED_TYPES), @response.body
  end
end