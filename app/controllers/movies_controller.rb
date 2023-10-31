class MoviesController < ApplicationController
  require 'httpclient'
  protect_from_forgery with: :null_session

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

  def search
    client = HTTPClient.new
    apiUrl = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['API_KEY']}&language=ja&page=1&query=#{params[:text]}"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movies = res_json['results']
  end
end
