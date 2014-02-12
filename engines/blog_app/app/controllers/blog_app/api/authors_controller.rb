module BlogApp::Api
  class AuthorsController < ApplicationController
    respond_to :json

    def index
      respond_with authors
    end

    def show
      respond_with author
    end

    private

    def authors
      @authors ||= BlogApp::Author.all
    end

    def author
      @author ||= BlogApp::Author.find_by_tumblr(params[:id])
    end
  end
end
