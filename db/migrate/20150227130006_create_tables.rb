class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.timestamps null: false
    end

    create_table :movies do |t|
      t.string :title
      t.string :thumbnail
      t.string :release_date
      t.text :synopsis
      t.timestamps null: false
    end

    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :movie_id, null: false
      t.text :comment
      t.timestamps null: false
    end

    create_table :upvotes do |t|
      t.integer :comment_id, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end

    create_table :user_movies do |t|
      t.integer :user_id, null: false
      t.integer :movie_id, null: false
      t.timestamps null: false
    end
  end
end

