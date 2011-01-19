require 'spec_helper'

describe CommentsController do
  let(:user) { mock_model User, :persistence_token => "foo", :has_role? => false, :email => "user@example.com" }

  before do
    @post = mock_model(Post, :to_param => 'test-post')
    Post.should_receive(:find_by_permalink).with('test-post').and_return(@post)
  end

  describe "GET /new" do
    it "should be success" do
      get :new, :post_id => 'test-post'
      response.should be_success
    end
    it "should assign comment" do
      Comment.should_receive(:new).and_return(:comment)
      get :new, :post_id => 'test-post'
      assigns(:comment).should eql(:comment)
    end
    it "should assign post" do
      get :new, :post_id => 'test-post'
      assigns(:post).should eql(@post)
    end
  end
  describe "POST /create" do
    before do
      @comments, @comment = mock(:comments), mock_model(Comment)

      @post.should_receive(:comments).and_return(@comments)
      @comments.should_receive(:build).with('name' => 'test').and_return(@comment)
    end

    describe "valid data" do
      before do
        @comment.should_receive(:save).and_return(true)
      end

      describe "not logged in" do
        before do
          controller.stub(:current_user => nil)
          @comment.should_receive(:user=).with(nil)
        end

        it "should redirect to post" do
          post :create, :post_id => 'test-post', :comment => {:name => 'test'}
          response.should redirect_to(post_path('test-post'))
        end

        it "should set flash message" do
          post :create, :post_id => 'test-post', :comment => {:name => 'test'}
          flash[:notice].should eql(I18n.t(:created_successfully_pending_approval))
        end
      end

      it "should use user id when logged in" do
        @comment.should_receive(:user=).with(user)
        controller.stub(:current_user => user)
        post :create, :post_id => 'test-post', :comment => {:name => 'test'}
      end
    end

    describe "invalid data" do
      before do
        controller.stub(:current_user => nil)
        @comment.should_receive(:user=).with(nil)
        @comment.should_receive(:save).and_return(false)
      end

      it "should render new" do
        post :create, :post_id => 'test-post', :comment => {:name => 'test'}
        response.should render_template('new')
      end

      it "should assign post" do
        post :create, :post_id => 'test-post', :comment => {:name => 'test'}
        assigns(:post).should eql(@post)
      end

      it "should assign comment" do
        post :create, :post_id => 'test-post', :comment => {:name => 'test'}
        assigns(:comment).should eql(@comment)
      end
    end
  end
end
