require 'rewrite'

module BlogApp
  class PostsController < ApplicationController
    respond_to :html, :rss, :json

    before_filter :old_post?, only: :show

    expose(:posts) { Post.published.by_publish_date }
    expose(:post) { Post.slugged(params[:id]) }
    expose(:popular_tags) { Post.tag_counts.order('count desc').limit(20) }
    expose(:authors) { Post.authors }
    expose(:author) { Author.find_by_tumblr(params[:author].to_s.downcase) }

    def index
      self.posts = self.posts.written_by(author[:tumblr]) if author
      self.posts = self.posts.tagged_with([params[:tagged]]) if params[:tagged]
      self.posts = self.posts.page(params[:page]).per(items_per_page)
      respond_with posts
    end

    def show
      redirect_to posts_path and return if post.nil?
      respond_with post
    end

    def for_date
      self.posts = Post.posted_on(params[:year], params[:month], params[:day])
      @total = Post.published.count
      respond_with self.posts
    end

    def archive
      self.posts = posts.group_by { |post| post.published_at.beginning_of_month }
      @total = Post.published.count
      respond_with self.posts
    end

    def search
      self.posts = Post.search(params[:q]).page(params[:page]).per(items_per_page)
      respond_with posts, template: 'blog_app/posts/index'
    end

    def old
      new_host = Rails.env.development? ? 'gaslight.dev' : 'gaslight.co'
      new_slug = Rewrite.new_post_url(request.fullpath)
      new_url = new_slug ? post_url(new_slug, host: new_host) : posts_url(host: new_host)
      redirect_to new_url, status: 301
    end

    def podcast_iframe
      respond_with post, layout: false
    end

    def options
      render nothing: true
    end

    def update
      post.update_attributes!(post_params)
      respond_with post
    end

    protected

    def search_date
      year = (params[:year] || Date.today.year).to_i
      month = (params[:month] || Date.today.month).to_i
      day = (params[:day] || Date.today.day).to_i
      Date.new(year, month, day)
    end
    helper_method :search_date

    def items_per_page
      return Post.count if %w(rss json).include?(request.format)
      index? ? 3 : 20
    end

    def index?
      actions = %w(q tagged author year)
      (params.keys & actions).none?
    end

    def old_post?
      if old = OldSlug.where(old_slug: params[:id] || params[:slug]).first
        redirect_to post_url(old.new_slug), status: 301
      end
    end

    def post_params
      params.require(:post).permit(:title, :description, :body, :slug, :audio_url, :author, :published_at,:author_image,:subreddit)
    end
  end
end
