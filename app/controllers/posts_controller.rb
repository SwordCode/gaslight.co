class PostsController < ApplicationController

  respond_to :html, :rss, :json

  def index
    respond_with posts
  end

  def recent
    respond_with(posts) do |format|
      format.html { render :index }
      format.rss { render template: 'posts/index', layout: false }
    end
  end

  protected

  def posts
    posts = recent? ? Post.recent : Post.published.by_publish_date
    posts = posts.tagged_with([params[:tagged]]) if params[:tagged]
    posts
  end
  helper_method :posts

  def post
    Post.published.find(params[:id])
  end
  helper_method :post

  def recent?
    request.fullpath =~ /#{recent_posts_path}/
  end
  helper_method :recent?

  def tagged
    posts.tagged_with(params[:tagged])
  end
end

