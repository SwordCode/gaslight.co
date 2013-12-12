require 'spec_helper'

module TrainingApp
  describe Registration do

    it { should validate_presence_of(:course) }
    it { should belong_to(:course) }

    describe "purchase!" do
      let(:course) { FactoryGirl.create(:course, price: 10000, title: "Super Happy Fun Time Javascript") }
      let(:registration) { FactoryGirl.build(:registration, course: course, email: "foo@bar.com") }
      let(:customer) { double("Customer", id: 1, error: error) }

      before do
        allow(Customer).to receive(:generate) { customer }
        expect(customer).to receive(:charge).with(amount: course.price, description: course.title)
        registration.purchase!(course.price)
      end

      describe "with a valid customer" do
        let(:error) {nil}

        it "assigns the customer id" do
          expect(registration.customer_id).to eq(customer.id)
        end

        it "sends the confirmation email" do
          expect(ActionMailer::Base.deliveries.last.to).to include(registration.email)
        end

        it "should be persisted" do
          expect(registration).to be_persisted
        end
      end

      describe "with an invalid customer" do

        before { ActionMailer::Base.deliveries.clear }

        let(:error) {"something's wrong"}

        it "adds the error to the registration" do
          expect(registration.errors[:base].first).to eq(error)
        end

        it "should not be persisted" do
          expect(registration).to_not be_persisted
        end

        it "doesn't send the confirmation email" do
          expect(ActionMailer::Base.deliveries).to be_empty
        end
      end
    end

    describe "bypassing purchase" do
      subject { FactoryGirl.create(:registration, freebie: true) }

      it { should be_valid }
      it { should_not be_new_record }
    end
  end
end

