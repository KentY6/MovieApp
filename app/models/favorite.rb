class Favorite < ApplicationRecord
    attribute :movie_title, :string
    attribute :movie_id, :integer
    attribute :movie_overview, :text
    attribute :movie_poster_path, :string

    belongs_to :user
end
