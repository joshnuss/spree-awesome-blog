require 'spec_helper'

describe PostsHelper do
  describe :make_title do
    context "no prameters" do
      it "should use blog title if present" do
        Spree::Config.should_receive(:[]).with(:blog_title).and_return(nil)
        make_title.should eql(t("blog"))
      end
      it "should use blog when no title present" do
        Spree::Config.should_receive(:[]).with(:blog_title).and_return('this is a test')
        make_title.should eql('this is a test')
      end
    end

    context "with tags" do
      it "should say by tag" do
        make_title("awesome").should eql("Posts tagged Awesome")
      end
    end

    context "with date" do
      it "should handle year" do
        make_title(nil, '2010').should eql("Posts for year 2010")
      end
      it "should handle month" do
        make_title(nil, '2010', '1').should eql("Posts for January 2010")
      end
      it "should handle day" do
        make_title(nil, '2011','1','1').should eql("Posts for Saturday, 01 January, 2011")
      end
    end
  end
end
