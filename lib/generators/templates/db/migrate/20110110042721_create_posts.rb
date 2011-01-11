class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.string :permalink
      t.text :summary
      t.text :body
      t.text :tags
      t.boolean :publish
      t.datetime :published_on
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
