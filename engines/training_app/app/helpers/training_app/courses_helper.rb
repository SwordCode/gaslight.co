require "redcarpet"

module TrainingApp
  module CoursesHelper
    def markdown(text)
      return "" unless text.present?
      @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
      @renderer.render(text).html_safe
    end

    def course_class(course)
      course.online? ? 'course--online' : 'course--in-person'
    end
  end
end