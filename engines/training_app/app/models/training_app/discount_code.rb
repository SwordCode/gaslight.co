module TrainingApp
  class DiscountCode < ActiveRecord::Base
    belongs_to :course

    validates :course, :price, :code, presence: true
  end
end
