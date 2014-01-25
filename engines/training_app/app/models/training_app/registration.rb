module TrainingApp
  class Registration < ActiveRecord::Base

    belongs_to :course
    belongs_to :discount_code

    validates_presence_of :name, :email, :course
    validates_uniqueness_of :code
    before_validation :generate_code, on: :create, unless: Proc.new { |r| r.code.present? }

    def purchase!(amount)
      self.amount = amount
      customer = Customer.generate(token: stripe_token, email: email, name: name)
      self.customer_id = customer.id
      if valid?
        charge = customer.charge(amount: amount, description: course.title) if amount > 0

        self.card_type = charge.card.type
        self.last4 = charge.card.last4
        self.expires_on = Date.new(charge.card.exp_year, charge.card.exp_month, 1)

        if customer.error.blank?
          save!
          send_confirmation
          return true
        else
          errors.add :base, customer.error
        end
      end
      return false
    end

    private

    def send_confirmation
      Confirmation.registered(self).deliver
    end

    def generate_code
      self.code = Digest::MD5.hexdigest("#{self.email}#{Time.now}")
    end
  end
end

