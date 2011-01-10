class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  before_save :check_approved
  before_save :check_user, :if => :user

  attr_accessible :name, :email, :message, :approved

  validates_presence_of :message, :post_id, :name
  validates_length_of   :message, :maximum => 1000
  validates_presence_of :email,   :unless => :user
  validates_format_of   :email,   :with => /\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i

  default_scope order('approved, approved_on DESC')
  scope :approved, where(:approved => true)

  def status
    approved ? "approved" : "not approved"
  end

private
  def check_user
    self.email = user.email
  end

  def check_approved
    return unless approved_changed?
    self.approved_on = approved ? Date.today : nil
  end
end
