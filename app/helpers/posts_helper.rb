module PostsHelper
  include ActsAsTaggableOn::TagsHelper

  def make_title(tag=nil, year=nil, month=nil, day=nil)
    if tag
      t("posts_tagged") % tag.humanize.capitalize
    elsif year
      if day
        t("posts_day") % Date.new(year.to_i,month.to_i,day.to_i).strftime("%A, %d %B, %Y")
      elsif month
        t("posts_month") % Date.new(year.to_i,month.to_i,1).strftime("%B %Y")
      else
        t("posts_year") % year.to_s
      end
    else
      Spree::Config[:blog_title] || t("blog")
    end
  end
end
