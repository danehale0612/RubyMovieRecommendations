class AddColumnsAndTable < ActiveRecord::Migration

  def change
    add_column(:movies, :Year, :string)
    add_column(:movies, :Rated, :string)
    add_column(:movies, :Released, :string)
    add_column(:movies, :Runtime, :string)
    add_column(:movies, :Genre, :string)
    add_column(:movies, :Director, :string)
    add_column(:movies, :Writer, :string)
    add_column(:movies, :Actors, :string)
    add_column(:movies, :RT_Score, :string)
    add_column(:movies, :Plot, :string)

    create_table :users do |t|
      t.string :name
    end
  end
end