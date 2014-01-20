module TrainingApp
  class DiscountCode < ActiveRecord::Base
    has_many :registrations
    belongs_to :course
    has_many :registrations

    validates :course, :price, :code, presence: true
    validate :has_remaining_uses, :has_not_expired

    def remaining_uses
      registrations.count
    end

    def expired?
      expires_on.present? && (Date.current >= expires_on)
    end

    def has_remaining_uses
      if maximum_uses > 0 && remaining_uses >= maximum_uses
        errors.add(:maximum_uses, 'has been exceeded')
      end
    end

    def has_not_expired
      errors.add(:expires_on, 'has expired') if expired?
    end
  end
end
