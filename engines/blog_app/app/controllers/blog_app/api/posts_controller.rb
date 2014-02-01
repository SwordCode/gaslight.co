require 'rewrite'

module BlogApp
  module Api
    class PostsController < ApplicationController
      respond_to :json

      before_filter :old_post?, only: :show

      expose(:posts)        { Post.published.by_publish_date                       }
      expose(:post)         { Post.slugged(params[:id] || params[:slug])           }
      expose(:popular_tags) { Post.tag_counts.order('count desc').limit(20)        }
      expose(:authors)      { Post.authors                                         }
      expose(:author)       { Author.find_by_tumblr(params[:author].to_s.downcase) }

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

      def podcast_iframe
        respond_with post, layout: false
      end

      def update
        post.update_attributes!(post_params)
        respond_with post
      end

      protected

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
        params.require(:post).permit(:title, :description, :body, :slug, :audio_url, :author, :published_at)
      end
    end
  end
end

