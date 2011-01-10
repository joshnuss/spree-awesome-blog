class Post < ActiveRecord::Base
  make_permalink
  acts_as_taggable
  validates_presence_of :title, :summary
  has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
  before_save :check_published

  scope :published, where(:publish => true)

  def self.by_date(year, month=nil, day=nil) 
    start_date = Date.new(year, month || 1, day || 1)
    end_date = nil

    if day 
      end_date = start_date.advance(:days   => 1)
    elsif month
      end_date = start_date.advance(:months => 1)
    else
      end_date = start_date.advance(:years  => 1)
    end

    where('published_on BETWEEN ? AND ?', start_date, end_date)
  end

  def to_param
    return permalink unless permalink.blank?
    title.to_url
  end 

private
  def check_published
    return unless publish_changed?
    self.published_on = publish ? Date.today : nil
  end
end
