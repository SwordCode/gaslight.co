require 'rewrite'

module BlogApp
  module Api
    class PostsController < ApplicationController
      respond_to :json

      before_filter :old_post?, only: :show

      expose(:posts)        { Post.order('created_at desc')                                              }
      expose(:post)         { Post.find_by_id(params[:id]) || Post.slugged(params[:id] || params[:slug]) }

      def index
        self.posts = self.posts.page(params[:page]).per(items_per_page)
        respond_with posts
      end

      def show
        respond_with post
      end

      def create
        self.post = Post.create(post_params)
        respond_with post
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

      def old_post?
        if old = OldSlug.where(old_slug: params[:id] || params[:slug]).first
          redirect_to post_url(old.new_slug), status: 301
        end
      end

      def post_params
        params.require(:post).permit(:title, :description, :body, :slug, :audio_url, :author, :published_at, :subreddit)
      end
    end
  end
end

