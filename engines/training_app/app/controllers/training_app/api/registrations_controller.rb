module TrainingApp
  module Api
    class RegistrationsController < ApplicationController
      respond_to :json

      def create
        registration = Registration.new(registration_params)
        if registration.purchase!
          session[:registration_code] = registration.code
          render json: { registration: registration }, status: :created
        else
          render json: { errors: registration.errors } , status: :unprocessable_entity
        end
      end

      def stats
        regs = Registration.where('created_at > ?', Date.new(2013, 5, 31))
        render json: { quantity: regs.size }
      end

      private

      def registration_params
        params.require(:registration).permit(:amount, :name, :email, :phone, :stripe_token, :course_id)
      end
    end
  end
end