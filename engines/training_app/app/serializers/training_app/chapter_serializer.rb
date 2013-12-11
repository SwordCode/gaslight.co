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
  end
end