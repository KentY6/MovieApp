class CreateFavorites < ActiveRecord::Migration[7.1]
    def change
        create_table "favorites", force: :cascade do |t|
            t.string "movie_title"
            t.text "movie_overview"
            t.string "movie_poster_path"
            t.integer "movie_id"
            t.integer "user_id"
            t.datetime "created_at", null: false
            t.datetime "updated_at", null: false
        end
    end
end
    