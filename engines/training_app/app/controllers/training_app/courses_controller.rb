module TrainingApp
  class CoursesController < ApplicationController

    respond_to :html

    expose(:upcoming_courses) { Course.active }
    expose(:previous_courses) { Course.past.limit(4) }
    expose(:course)
  end
end

