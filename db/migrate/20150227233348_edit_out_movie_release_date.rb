class EditOutMovieReleaseDate < ActiveRecord::Migration
  def change
    remove_column :movies, :release_date
  end
end
