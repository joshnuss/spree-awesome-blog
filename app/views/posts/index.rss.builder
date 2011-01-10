xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title(Spree::Config[:blog_title] || "#{Spree::Config['site_name']} Blog")
    xml.link(posts_url)
    xml.description("")
    xml.language('en-us')
    for post in @posts
      xml.item do
        xml.title(post.title)
        xml.description(post.summary + "<br/>#{link_to 'Read More', post_url(post)}")      
        xml.pubDate(post.published_on.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link(post_url(post))
        xml.guid(post.permalink)
      end
    end
  }
}
