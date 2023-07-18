require "test_helper"

TOKEN = "thisisareallyreallyreallylongbearertoken"

TOKEN_BODY = JSON.generate({
      "token_type" => "Bearer",
      "expires_in" => 3600,
      "access_token" => TOKEN
    })

class PetfinderServiceTest < ActiveSupport::TestCase
  test "get_bearer_token" do
    service = PetfinderService.new()

    stub_request(:post, service.url("token"))
      .to_return(body: TOKEN_BODY)

    response = service.get_bearer_token()
    assert_equal TOKEN, response
  end

  test "call_api" do
    service = PetfinderService.new()

    stub_request(:post, service.url("token"))
      .to_return(body: TOKEN_BODY)

    stub_request(:get, service.url("animal_types"))
      .to_return(body: File.new("test/fixtures/files/petfinder/types.json"))

    response = service.call_api("animal_types")
    assert_equal response.keys, ["types"]
    types = response["types"]
    assert types.length
    for type in types do
      assert_equal type.keys, ["name", "coats", "colors", "genders", "_links"]
    end
  end
end