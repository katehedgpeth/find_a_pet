class Api::V1::AnimalTypesController < ApplicationController
  def index
    render(json: get_type_names())
  end

  # ------------------------------------------------------
  private

  def get_type_names
    PetfinderService.new()
      .call_api("animal_types")
      .then { extract_type_names_from_response(_1) }
  end

  def extract_type_names_from_response(response)
    response["types"].map { |type| type["name"] }
  end
end