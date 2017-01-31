require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================


    @street_address_without_spaces = @street_address.gsub(" ","+")
    @url_1 = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address_without_spaces}"
    @parsed_data = JSON.parse(open(@url_1).read)
    @latitude = @parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = @parsed_data["results"][0]["geometry"]["location"]["lng"]
    @url_2 = "https://api.darksky.net/forecast/1bc23d7f9d6756035ed21e099b38da77/#{@latitude},#{@longitude}"
    @reparsed_data = JSON.parse(open(@url_2).read)

    @current_temperature = @reparsed_data["currently"]["temperature"]

    @current_summary = @reparsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = @reparsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = @reparsed_data["hourly"]["summary"]

    @summary_of_next_several_days = @reparsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
