class CreateColumnRemoveColumn < ActiveRecord::Migration
  def up
    change_table :user_movies do |t|
      t.string :movie_title
    end

    def down
      remove_column :user_movies, :movie_id
    end
  end
end