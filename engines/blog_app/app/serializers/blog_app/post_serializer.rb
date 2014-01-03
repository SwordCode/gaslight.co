module BlogApp
  class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :slug, :audio_url, :author, :author_image,
      :published_at, :description, :body

    def author_image
      return "" if object.author_email.nil?
      hash = Digest::MD5.hexdigest(object.author_email)
      "//www.gravatar.com/avatar/#{hash}"
    end
  end
end

