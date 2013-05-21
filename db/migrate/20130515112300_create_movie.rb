class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :Title
      t.string :Year
      t.string :Rated
      t.string :Released
      t.string :Runtime
      t.string :Genre
      t.string :Director
      t.string :Writer
      t.string :Actors
      t.string :RT_Score
      t.string :Plot
    end

    
  end

end
