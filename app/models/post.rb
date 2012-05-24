class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :category

  has_many :comments, :dependent => :destroy

  attr_accessible :category_id, :title, :body, :spot, :tag_list, :published
  attr_accessor :tag

  validates :title, :presence => true
  validates :body, :presence => true
  validates_presence_of :published_at, :if => :published
  validates :user_id, :presence => true

  default_scope :order => 'posts.created_at DESC'
  
  acts_as_taggable  
  
  # Syntax highlight özelliği için başka yöntem yada gist kullanılacak.
  # before_save :render_body  
  
  def self.feed(last)
		self.where("created_at < ? ", last).order('created_at desc').limit(5)
	end

  def render_body
    require 'redcarpet'
    options = [:hard_wrap, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    self.rendered_body = Redcarpet.new(self.body, *options).to_html
  end
  
  def is_author?
    author
  end
  def self.search(query)
    search_condition = "%" + query + "%"
    find(:all, :conditions => ['title LIKE ? OR body LIKE ?', search_condition, search_condition])
  end
  
end

