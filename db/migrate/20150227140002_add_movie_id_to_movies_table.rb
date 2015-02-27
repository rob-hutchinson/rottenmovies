class AddMovieIdToMoviesTable < ActiveRecord::Migration
  def change
    add_column :movies, :rotten_id, :integer
  end
end
