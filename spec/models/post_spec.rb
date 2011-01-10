require 'spec_helper'

describe Post do
  describe "when creating" do
    it "should be valid" do
      create_post.should have(0).errors
    end

    it "should require title" do
      create_post(:title => '').should have(1).error_on(:title)
    end

    it "should require summary" do
      create_post(:summary => nil).should have(1).error_on(:summary)
    end

    it "should have permalink" do
      post = create_post(:title => 'Test Post')
      post.permalink.should eql('test-post')
    end
  end

  describe "status" do
    it "should be unpublished for new post" do
      create_post.status.should eql('unpublished')
    end

    it "should be published after post is published" do
      create_post(:publish => true).status.should eql('published')
    end
  end

  it "should have images" do
    create_post.should have(0).images
  end

  it "should have comment" do
    create_post.should have(0).comments
  end

  describe "when publishing" do
    it "should save publish date" do
      post = create_post(:publish => true)
      post.published_on.to_date.should eql(Date.today)
    end

    it "should not change publish date, unless publish is changed" do
      post = create_post(:publish => true)
      post.update_attribute(:published_on, Date.new(2011,1,1))
      post.published_on.to_date.should eql(Date.new(2011,1,1))
    end

    it "should remove publish date when unpublished" do
      post = create_post(:publish => true)
      post.update_attribute(:publish, false)
      post.published_on.should be_nil
    end

    it "should find published" do
      2.times { create_post(:publish => true) }
      Post.published.should have(2).posts
    end
  end

  describe "tagging" do
    it "should be taggable" do
      post = create_post(:tag_list => 'awesome,cool')
      post.tag_list.should have(2).tags
    end

    it "should find by tags" do
      2.times { create_post(:tag_list => 'awesome,cool') }
      Post.tagged_with('awesome').should have(2).posts
    end
  end

  describe "finding" do
    it "should find by year" do
      create_post(:publish => true)
      Post.by_date(Date.today.year).should have(1).posts
    end

    it "should find by month" do
      create_post(:publish => true)
      post = create_post(:publish => true)
      post.update_attribute(:published_on, Date.today.advance(:months => 1))
      Post.by_date(Date.today.year, Date.today.month).should have(1).posts
    end

    it "should find by day" do
      create_post(:publish => true)
      post = create_post(:publish => true)
      post.update_attribute(:published_on, Date.today.advance(:days => 1))
      Post.by_date(Date.today.year, Date.today.month, Date.today.day).should have(1).posts
    end
  end

  def create_post(options={})
    Post.create({:title => 'test', :summary => 'this is a summary'}.merge(options))
  end
end
