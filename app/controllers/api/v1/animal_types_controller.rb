class Api::V1::AnimalTypesController < ApplicationController
  def index
    render(json: get_types())
  end

  # ------------------------------------------------------
  private

  def get_types
    PetfinderService.new()
      .call_api("animal_types")
      .fetch("types")
      .map { transform_type_data(_1) }
  end

  def transform_type_data(data_hash)
    data_hash["slug"] = get_slug(data_hash)
    data_hash.delete("_links")
    return data_hash
  end

  def get_slug(data_hash)
    data_hash
      .fetch("_links")
      .fetch("self")
      .fetch("href")
      .split("/")
      .last()
  end
end