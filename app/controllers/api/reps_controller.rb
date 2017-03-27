class Api::RepsController < ApplicationController
  def index
    address = params["address"]
    coords = params["coords"]
    # TODO: refactor into helper?
    # TODO: better validation than not string
    if coords.class != String && ["lat", "lng"].all? { |key| coords.key? key }
      url = 'https://maps.googleapis.com/maps/api/geocode/json?'
      key = ENV["GOOGLE_MAPS_API_KEY"]
      response = HTTParty.get("#{url}latlng=#{coords["lat"]},#{coords["lng"]}&key=#{key}")
      address = response["results"].first["formatted_address"]
    end
    api_url = "https://www.googleapis.com/civicinfo/v2/representatives?"
    address = "address=#{address}"
    api_key = "key=#{ENV['GOOGLE_CIVIC_API_KEY']}"
    levels = "levels=country"
    offices = "includeOffices=false"
    roles = "roles=legislatorLowerBody"
    request = "#{api_url}#{address}&#{api_key}&#{levels}&#{offices}&#{roles}"
    response = HTTParty.get(request, format: :plain)
    parsed = JSON.parse response, symbolize_names: true
    begin
      division = parsed[:divisions].keys.first.to_s.split(/cd:/)
      district = division.length == 1 ? "1" : division.last
      state = parsed[:normalizedInput][:state]
      representative = Rep.find_by(district: district, state: state)
      senators = Rep.where(state: state, title: 'Senator')
      @reps = [*senators, representative]
      current_user.create_ties(@reps) if current_user
    rescue => e
      # TODO: Add customs error messages
      # result = { message: 'Created Ties', success: true }
      render json: {errors: "ERROR"}, status: 400
    end
  end
end