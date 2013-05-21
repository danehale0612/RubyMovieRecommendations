class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column(:movies, :name, :Title)
  end
end