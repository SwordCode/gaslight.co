module TrainingApp
  class ClassroomController < ApplicationController
    layout "training_app/layouts/classroom"
    respond_to :html

    def index
      session[:registration_code] = registration.code if registration.present?
    end

    def registration
      @registration ||= Registration.find_by_code(params[:code])
    end
  end
end

