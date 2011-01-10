require 'spec_helper'

describe PostsController do
  describe "GET /show" do
    it "should be success" do
      get :show, :id => 'test'
      response.should be_success
    end

    it "assign post" do
      published = mock(:published)
      Post.should_receive(:published).and_return(published)
      published.should_receive(:find_by_permalink).with('test').and_return(:post)
      get :show, :id => 'test'
      assigns(:post).should eql(:post)
    end
  end

  describe "GET /index" do
    it "should be success" do
      get :index
      response.should be_success
    end

    it "should assign posts" do
      published = mock(:published)
      Post.should_receive(:published).and_return(published)
      published.should_receive(:paginate).with(:page => 2).and_return(:posts)
      get :index, :page => 2
      assigns(:posts).should eql(:posts)
    end
  end

  describe "GET /index.rss" do
    it "should be success" do
      get :index, :format => :rss
      response.should be_success
    end

    it "should assign posts" do
      Post.should_receive(:published).and_return(:posts)
      get :index, :format => :rss
      assigns(:posts).should eql(:posts)
    end
  end

  describe "GET /index with tags" do
    it "should be success" do
      get :index, :tag => 'awesome'
      response.should be_success
    end

    it "should assign posts" do
      published, tagged = mock(:published), mock(:tagged)
      Post.should_receive(:published).and_return(published)
      published.should_receive(:tagged_with).with('awesome').and_return(tagged)
      published.should_receive(:paginate).with(:page => 2).and_return(:posts)
      get :index, :tag => 'awesome', :page => 2
      assigns(:posts).should eql(:posts)
      assigns(:tag).should eql('awesome')
    end
  end

  describe "GET /index with date" do
    it "should be success" do
      get :index, :year => 2010, :month => 2, :day => 1
      response.should be_success
    end

    it "should assign posts" do
      published, by_date = mock(:published), mock(:by_date)
      Post.should_receive(:by_date).with(2010,2,1).and_return(by_date)
      by_date.should_receive(:published).and_return(published)
      published.should_receive(:paginate).with(:page => 2).and_return(:posts)
      get :index, :year => 2010, :month => 2, :day => 1, :page => 2
      assigns(:posts).should eql(:posts)
      assigns(:year).should eql(2010)
      assigns(:month).should eql(2)
      assigns(:day).should eql(1)
    end
  end
end
