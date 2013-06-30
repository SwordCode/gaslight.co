class Post < ActiveRecord::Base

  def self.published
    where(published: true)
  end

  def self.by_publish_date
    order('published_at desc')
  end

  def self.recent(max = 5)
    published.by_publish_date.limit(max)
  end

  def self.tagged(tag)
    tag ? published.tagged_with(tag.split) : scoped
  end

  def self.search(query)
    published.where('lower(posts.body) like lower(?)', "% #{query} %")
  end

  def self.written_by(author)
    published.where(author: author).by_publish_date
  end

  def self.posted_on(year = nil, month = nil, day = nil)
    posts = published
    posts = posts.where('extract(year  from published_at) = ?', year) unless year.nil?
    posts = posts.where('extract(month from published_at) = ?', month) unless month.nil?
    posts = posts.where('extract(day   from published_at) = ?', day) unless day.nil?
    posts
  end

  validates_presence_of :title, :body, :author
  validates_length_of :title, maximum: 255

  after_validation :update_html
  attr_taggable :tags

  def published_on
    (published_at || Time.now).to_date
  end

  def title
    read_attribute(:title) || ""
  end

  def tag_list
    tags = self.tags
    tags.empty? ? [] : tags.join(', ')
  end

  def tag_list=(list)
    list.gsub!(/,\Z/, '')
    self.tags = list
  end

  def next
    Post.where("published_at > ?", published_at).order("published_at desc").first
  end

  def previous
    Post.where("published_at < ?", published_at).order("published_at desc").first
  end

  private

  def update_html
    return true if body.nil?
    self.html = Renderer.render(body)
  end
end

