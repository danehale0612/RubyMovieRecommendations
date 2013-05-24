class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column(:user_movies, :movie_id)
  end
end