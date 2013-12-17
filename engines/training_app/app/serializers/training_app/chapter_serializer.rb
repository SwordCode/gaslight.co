module TrainingApp
  class ChapterSerializer < ActiveModel::Serializer
    attributes :id, :title, :sort_order, :description, :duration, :video_url, :code_url, :poster_url, :section_id, :demo

    def attributes
      attrs = super
      if registration.nil? && !object.demo?
        [:code_url, :video_url, :poster_url, :description].each { |attr| attrs[attr] = nil}
      end
      attrs
    end

    def video_url
      "//#{ENV.fetch('CLOUDFRONT_CDN_DOMAIN')}#{object.video_url}"
    end

    def poster_url
      "//#{ENV.fetch('CLOUDFRONT_CDN_DOMAIN')}#{object.poster_url}"
    end
  end
end