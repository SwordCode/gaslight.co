module TrainingApp
  module Api
    class DiscountCodesController < ApplicationController
      def show
        if discount_code = DiscountCode.find_by_code(params[:id])
          render json: { discount_code: discount_code }
        else
          render nothing: true, status: :not_found
        end
      end
    end
  end
end