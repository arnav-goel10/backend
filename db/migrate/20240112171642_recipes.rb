class Recipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :desc
      t.integer :like_count, default: 0
      t.integer :comments_count, default: 0
      t.timestamps

      # Add a foreign key constraint to link user_id with the users table
      t.references :user, foreign_key: true
    end
  end

end
