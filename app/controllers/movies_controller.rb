class MoviesController < ApplicationController
  def index
    @movies = Movies.all
  end

  def show
  end
end
