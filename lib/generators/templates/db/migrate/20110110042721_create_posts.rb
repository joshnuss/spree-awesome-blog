class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.string :permalink
      t.text :summary
      t.text :body
      t.boolean :published
      t.datetime :published_on

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
