module TrainingApp
  class CoursesController < ApplicationController

    respond_to :html

    expose(:upcoming_courses) { Course.active.where('parent_course_id is not null OR online = true') }
    expose(:previous_courses) { Course.past.limit(4) }
    expose(:course)
  end
end

