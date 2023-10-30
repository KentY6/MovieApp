class MoviesController < ApplicationController
  require 'httpclient'

  def index
    client = HTTPClient.new
    apiUrl = "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['API_KEY']}&language=ja"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movies = res_json['results']
  end

  def show
    client = HTTPClient.new
    apiUrl = "https://api.themoviedb.org/3/movie/#{params[:id]}?api_key=#{ENV['API_KEY']}&language=ja"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movie = res_json

  end
end
