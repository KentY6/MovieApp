class MoviesController < ApplicationController
  require 'httpclient'
  protect_from_forgery with: :null_session

  APIURL = "https://api.themoviedb.org/3/"

  # カテゴリー項目取得
  Client = HTTPClient.new
  CategoriesUrl = "#{APIURL}genre/movie/list?api_key=#{ENV['API_KEY']}&language=ja"
  CategoriesResponce = Client.get(CategoriesUrl)
  CategoriesRes_json = JSON.parse(CategoriesResponce.body)

  def index
    client = HTTPClient.new
    apiUrl = "#{APIURL}movie/popular?api_key=#{ENV['API_KEY']}&language=ja"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movies = res_json['results']

    @categories = CategoriesRes_json['genres']
  end

  def show
    client = HTTPClient.new
    apiUrl = "#{APIURL}movie/#{params[:id]}?api_key=#{ENV['API_KEY']}&language=ja"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movie = res_json

    if user_signed_in?
      @is_favorite = current_user.favorites.find_by(movie_id: @movie["id"]).present?
    end
    @categories = CategoriesRes_json['genres']
  end

  def search
    @search_word = URI.encode_www_form_component(params[:text])
    @result_word = params[:text]
    client = HTTPClient.new
    apiUrl = "#{APIURL}search/movie?api_key=#{ENV['API_KEY']}&language=ja&page=1&query=#{@search_word}"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movies = res_json['results']
    @results_length = @movies.length

    @categories = CategoriesRes_json['genres']
  end

  def category
    client = HTTPClient.new
    apiUrl = "#{APIURL}discover/movie?with_genres=#{params[:id]}&api_key=#{ENV['API_KEY']}&language=ja"
    responce = client.get(apiUrl)
    res_json = JSON.parse(responce.body)
    @movies = res_json['results']
    @categoryName = params[:name]

    @categories = CategoriesRes_json['genres']
  end

  def favorite
    #head :no_content
    @movie = params[:movie]
    @categories = CategoriesRes_json['genres']

    if favorite_exists?(@movie)
      @favorite = Favorite.find_by(movie_id: @movie["id"])
      @favorite.destroy
      flash[:notice] = "お気に入りから削除しました。"
      redirect_to movies_path
    else
      @favorite = Favorite.new(
        movie_title: @movie["title"],
        movie_id: @movie["id"].to_i,
        movie_overview: @movie["overview"],
        movie_poster_path: @movie["poster_path"],
        user_id: current_user.id
      )
      redirect_to movies_path

      if @favorite.save
        flash[:notice] = "#{@movie["title"]}をお気に入りに追加しました。"
      else
        flash[:alert] = "お気に入りに追加できませんでした。"
        logger.debug(@favorite.errors.full_messages) 
      end
    end
  end

  def favorites_list
    @favorites = current_user.favorites
    @categories = CategoriesRes_json['genres']
  end

  def destroy
    @favorite = Favorite.find_by(movie_id: params[:movie]["id"])
    @favorite.destroy
    
    redirect_to movies_path, notice: "お気に入りから削除しました。"  
  end

  private
    def favorite_exists?(movie)
      current_user.favorites.find_by(movie_id: movie["id"]).present? 
    end

end
