module TrainingApp
  class DiscountCode < ActiveRecord::Base
    has_many :registrations
    belongs_to :course

    validates :course, :price, :code, presence: true
  end
end
