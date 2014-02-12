module TrainingApp
  module Api
    class RegistrationsController < ApplicationController
      respond_to :json

      def create
        registration = Registration.new(registration_params)

        if discounted?
          registration.discount_code = discount_code
          price = discount_code.price
        else
          price = registration.course.price
        end

        if registration.purchase!(price)
          session[:registration_code] = registration.code
          render json: { registration: registration }, status: :created
        else
          render json: { registration: registration, error_message: registration.errors.full_messages.to_sentence } , status: :unprocessable_entity
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

      def discounted?
        discount_code.present?
      end

      def discount_code
        @discount_code = DiscountCode.find_by_code(params[:registration][:discount_code])
      end
    end
  end
end