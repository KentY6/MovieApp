class MoviesController < ApplicationController
  require 'httpclient'
  protect_from_forgery with: :null_session

  APIURL = "https://api.themoviedb.org/3/"

  def index
    client = HTTPClient.new
    apiUrl = "#{APIURL}movie/popular?api_key=#{ENV['API_KEY']}&language=ja"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movies = res_json['results']

    categoriesUrl = "#{APIURL}genre/movie/list?api_key=#{ENV['API_KEY']}&language=ja"
    categoriesResponce = client.get(categoriesUrl)
    categoriesRes_json = JSON.parse(categoriesResponce.body)
    @categories = categoriesRes_json['genres']

  end

  def show
    client = HTTPClient.new
    apiUrl = "#{APIURL}movie/#{params[:id]}?api_key=#{ENV['API_KEY']}&language=ja"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movie = res_json
  end

  def search
    @search_word = params[:text]
    client = HTTPClient.new
    apiUrl = "#{APIURL}search/movie?api_key=#{ENV['API_KEY']}&language=ja&page=1&query=#{@search_word}"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movies = res_json['results']
    @results_length = @movies.length

    categoriesUrl = "#{APIURL}genre/movie/list?api_key=#{ENV['API_KEY']}&language=ja"
    categoriesResponce = client.get(categoriesUrl)
    categoriesRes_json = JSON.parse(categoriesResponce.body)
    @categories = categoriesRes_json['genres']
  end

  def category
    client = HTTPClient.new
    apiUrl = "#{APIURL}discover/movie?with_genres=#{params[:id]}&api_key=#{ENV['API_KEY']}&language=ja"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movies = res_json['results']
    @categoryName = params[:name]

    categoriesUrl = "#{APIURL}genre/movie/list?api_key=#{ENV['API_KEY']}&language=ja"
    categoriesResponce = client.get(categoriesUrl)
    categoriesRes_json = JSON.parse(categoriesResponce.body)
    @categories = categoriesRes_json['genres']

  end
end
