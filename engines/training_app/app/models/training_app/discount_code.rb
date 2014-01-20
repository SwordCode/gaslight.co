module TrainingApp
  class DiscountCode < ActiveRecord::Base
    has_many :registrations
    belongs_to :course
    has_many :registrations

    validates :course, :price, :code, presence: true
    validate :has_remaining_uses

    def remaining_uses
      registrations.count
    end

    def has_remaining_uses
      errors.add(:maximum_uses, 'has been exceeded') if remaining_uses >= maximum_uses
    end
  end
end
