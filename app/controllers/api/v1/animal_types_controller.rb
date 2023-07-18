require 'net/http'
class Api::V1::AnimalTypesController < ApplicationController
  def index
    service = PetfinderService.new()
    @type_names = service.call_api("animal_types")["types"].map { |type| type["name"] }

    respond_to do |format|
      format.json { render json: @type_names }
    end
  end
end