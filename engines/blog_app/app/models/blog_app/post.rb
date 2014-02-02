require 'htmlentities'

module BlogApp
  class Post < ActiveRecord::Base
    include ActionView::Helpers::SanitizeHelper

    has_many :old_slugs

    def self.tags
      all.inject([]) {|tags,post| tags | post.tag_list}
    end

    def self.published
      where('published_at <= ?', Time.now)
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
      published.where('lower(body) like lower(:q) or lower(body) like lower(:q)', q: "%#{query}%")
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

    def self.authors
      published.select('author, count(id) as post_count').group('author').order('post_count desc')
    end

    def self.slugged(slug)
      find_by_slug(slug)
    end

    validates_presence_of :title, :body, :author
    validates_length_of :title, maximum: 255

    after_validation :update_html
    before_save :update_changed_slugs

    acts_as_ordered_taggable
    acts_as_url :title, url_attribute: :slug, sync_url: true

    include BlogApp::Engine.routes.url_helpers
    self.default_url_options = {
      :host => 'gaslight.co'
    }

    def url
      post_url(self)
    end

    def legacy_url
      tumblr_posts_hash = Rewrite.tumblr_posts_hash.invert
      if tumblr_post_id = tumblr_posts_hash[slug]
        "http://blog.gaslight.co/post/#{tumblr_post_id}/#{slug}"
      else
        nil
      end
    end

    def to_param
      slug
    end

    def published_on
      (published_at || Time.now).to_date
    end

    def title
      read_attribute(:title) || ""
    end

    def next
      Post.where("published_at > ?", published_at).order("published_at asc").first
    end

    def previous
      Post.where("published_at < ?", published_at).order("published_at desc").first
    end

    def type
      return "audio" if audio_url.present?
      "article"
    end

    def related(limit = 10)
      related_posts = [] |
        Post.tagged_with(tags, match_all: true) |
        Post.tagged_with([tags.first]) |
        find_related_tags
      related_posts.delete(self)
      related_posts.slice(0,limit)
    end

    def author_info
      @a ||= Author.find_by_tumblr(self.author)
      @a ||= {}
    end

    def author_name
      author_info[:name]
    end

    def author_email
      author_info[:email]
    end

    def author_google_plus_url
      author_info[:google_plus]
    end

    def published?
      persisted? && published_at && published_at <= Time.now
    end

    def generated_description
      desc = description || generate_description
      HTMLEntities.new.decode(desc)
    end

    private

    def update_html
      return true if body.nil?
      self.html = Renderer.render(body)
    end

    def update_changed_slugs
      if self.slug_changed?
        self.old_slugs.build(old_slug: self.slug_was, new_slug: self.slug)
      end
    end

    def generate_description
      strip_tags(html)
    end
  end

end
