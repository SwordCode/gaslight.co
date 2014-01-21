module TrainingApp
  module Api
    class DiscountCodesController < ApplicationController
      def show
        if discount_code
          render json: { discount_code: discount_code }
        else
          render nothing: true, status: :not_found
        end
      end

      def discount_code
        code ||= DiscountCode.search(params[:id], params[:course_id]).first
        @discount_code = code.valid? ? code : nil
      end
    end
  end
end