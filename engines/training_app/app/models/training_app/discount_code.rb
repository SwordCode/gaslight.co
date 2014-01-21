module TrainingApp
  class DiscountCode < ActiveRecord::Base
    has_many :registrations
    belongs_to :course
    has_many :registrations

    validates :course, :price, :code, presence: true
    validate :has_remaining_uses, :has_not_expired

    def self.search(code, course_id)
      where(course_id: course_id, code: code)
    end

    def name
      [course.name, code].join(' - ')
    end

    def uses
      registrations.count
    end

    def remaining_uses
      maximum_uses > 0 ? maximum_uses - uses : 100
    end

    def expired?
      expires_on.present? && (Date.current >= expires_on)
    end

    def has_remaining_uses
      if maximum_uses > 0 && remaining_uses <= 0
        errors.add(:maximum_uses, 'has been exceeded')
      end
    end

    def has_not_expired
      errors.add(:expires_on, 'has expired') if expired?
    end
  end
end
