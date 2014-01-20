require 'spec_helper'

module TrainingApp
  describe Registration do

    it { should validate_presence_of(:course) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should belong_to(:course) }

    describe "purchase!" do
      let(:course) { FactoryGirl.create(:course, price: 10000, title: "Super Happy Fun Time Javascript") }
      let(:registration) { FactoryGirl.build(:registration, course: course, email: "foo@bar.com") }
      let(:customer) { double("Customer", id: 1, error: stripe_error) }

      before do
        ActionMailer::Base.deliveries.clear
        allow(Customer).to receive(:generate) { customer }
      end

      context "with a valid customer" do
        let(:stripe_error) { nil }

        it "charges the user" do
          expect(customer).to receive(:charge).with(amount: course.price, description: course.title)
          registration.purchase!(course.price)
          expect(registration.customer_id).to eq(customer.id)
          expect(ActionMailer::Base.deliveries.last.to).to include(registration.email)
          expect(registration).to be_persisted
        end
      end

      context "with an invalid stripe customer" do
        let(:stripe_error) {"something's wrong"}

        it "adds errors to the registration" do
          expect(customer).to receive(:charge).with(amount: course.price, description: course.title)
          registration.purchase!(course.price)
          expect(registration.errors[:base].first).to eq(stripe_error)
          expect(registration).to_not be_persisted
          expect(ActionMailer::Base.deliveries).to be_empty
        end
      end

      context "with an invalid registration" do
        let(:invalid_registration) { FactoryGirl.build(:registration, course: course, email: nil) }
        let(:stripe_error) { nil }

        it "doesn't charge the user" do
          expect(customer).to_not receive(:charge)
          invalid_registration.purchase!(course.price)
          expect(invalid_registration).to_not be_valid
          expect(invalid_registration).to_not be_persisted
          expect(ActionMailer::Base.deliveries).to be_empty
        end
      end

      context "with a zero amount" do
        let(:stripe_error) { nil }

        it "doesn't charge the user" do
          expect(customer).to_not receive(:charge)
          registration.purchase!(0)
          expect(registration).to be_persisted
          expect(ActionMailer::Base.deliveries.last.to).to include(registration.email)
        end
      end
    end

    describe 'discounted registrations' do
      let(:discount_code) do
        DiscountCode.new(price: 100, course: subject.course, code: 'test1')
      end

      before do
        subject.course = Course.new
        subject.name = 'Test Person'
        subject.email = 'admin@example.com'
        subject.discount_code = discount_code
      end

      context 'with no conditions' do
        it { expect(subject).to be_valid }
      end

      context 'with a limited number of uses' do
        context 'before the maximum is reached' do
          before { discount_code.maximum_uses = 2 }
          it { expect(subject).to be_valid }
        end

        context 'after the maximum is reached' do
          before do
            allow(discount_code).to receive(:remaining_uses).and_return(1)
            subject.discount_code.maximum_uses = 1
          end

          it { expect(subject).to_not be_valid }
        end
      end

      context 'with an expiration date' do
        context 'prior to the expiration date' do
          before { discount_code.expires_on = 1.week.from_now }
          it { expect(subject).to be_valid }
        end

        context 'on or after the expiration date' do
          before { discount_code.expires_on = 1.week.ago }
          it { expect(subject).to_not be_valid }
        end
      end
    end
  end
end

