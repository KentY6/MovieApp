class MoviesController < ApplicationController
  require 'httpclient'

  def index
    client = HTTPClient.new
    apiUrl = "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['API_KEY']}&language=ja"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movies = res_json
    puts @movies
  end

  def show
  end
end
