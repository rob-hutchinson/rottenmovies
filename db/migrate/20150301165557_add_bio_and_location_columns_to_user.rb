class AddBioAndLocationColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :location, :string, limit: 20
  end
end
