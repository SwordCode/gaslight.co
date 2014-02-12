module TrainingApp
  class RegistrationsController < ApplicationController
    layout false
    expose(:registration) { Registration.find_by_code(params[:id]) }
    expose(:course) { registration.course }
  end
end
