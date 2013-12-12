module TrainingApp
  module Api
    class CoursesController < ApplicationController
      respond_to :json

      serialization_scope :registration

      def registration
        @registration = Registration.find_by_code(session[:registration_code])
      end

      def show
        respond_with(Course.find(params[:id]))
      end
    end
  end
end