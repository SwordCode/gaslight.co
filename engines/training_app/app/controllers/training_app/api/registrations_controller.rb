module TrainingApp
  module Api
    class RegistrationsController < ApplicationController
      respond_to :json

      def create
        registration = Registration.new(registration_params)
        registration.purchase!
        respond_with registration
      end

      def stats
        regs = Registration.where('created_at > ?', Date.new(2013, 5, 31))
        render json: { quantity: regs.size }
      end

      private

      def registration_params
        # TODO - add :discount_code
        params.require(:registration).permit(:amount, :name, :email, :phone, :stripe_token, :course_id)
      end
    end
  end
end