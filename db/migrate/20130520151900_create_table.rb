class CreateTable < ActiveRecord::Migration
  def change
    create_table :user_movies do |t|
      t.integer :user_id
      t.integer :move_id
      t.string :movie_status
    end
  end
end
